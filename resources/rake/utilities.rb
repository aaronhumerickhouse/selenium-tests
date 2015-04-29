require 'tempfile'

# Helpers for Rake Tasks
module RakeUtilities

#Redirects the output for a given fork to a tempfile
# Sets global variable $initial_stdout for cleanup
#
# @param temp_file [Tempfile] The Tempfile to redirect output to
  def redirect_stdout(temp_file)
    #file_name = "temp_out#{index}.txt"
    $initial_stdout = $stdout.dup
    #File.delete(file_name) if File.exist?(file_name)

    #file = File.new(file_name, 'w')
    #puts "Directing output from fork #{index} to #{file_name}"
    $stdout.reopen(temp_file)
  end


# Takes a space delimited list of tags and turns into rspec friendly tag format
#
# @param tags [String] Space delimited list of tags
# @return [String] RSpec friendly list of tags
  def get_tags(tags)
    tag_string = ''
    tag_array = tags.split(' ')
    tag_array.each { |tag| tag_string << " -t #{tag}" }
    tag_string
  end

# Retrieves all forked outputs and makes them readable
#
# @param tests [String] The list of tests that were tested
# @param temp_files [Tempfile Array] The tempfile with output from the forked process
  def friendly_output(tests, temp_files)
    output = ''
    temp_files.each_with_index do |temp_file, i|
      (1..2).each { output << SPACING }
      output << "\nFork #{i} completed, tested:\n#{tests[i]}"
      temp_file.rewind
      output << temp_file.read
      (1..2).each { output << SPACING }
      output << "\n\n"
    end
    output
  end

# Retrieves the number of processes to fork.  Will ensure it's greater than 0 and less than MAX_SAUCE_NODES
# @param forks [Integer] The number of desired parallel executions.
# @param files_size [Integer] The number of tests being executed.
# @return [Integer] The number of processes that will be forked
  def get_forks(forks, files_size)
    forks = [forks, files_size, MAX_SAUCE_NODES].min
    forks == 0 ? 1 : forks
  end

# Returns the tests for execution
# @param pattern [String] Ant pattern to select tests
# @param tags [String] RSpec friendly tags
# @param opts [String] RSpec opts
# @return [String Array] Array of test files
  def get_suites(pattern, tags, opts)
    if ENV['RM_INFO']
      get_suites_rubymine(pattern, tags, opts)
    else
      get_suites_console(pattern, tags, opts)
    end
  end

# Returns the tests for execution, if executed in terminal
# @param pattern [String] Ant pattern to select tests
# @param tags [String] RSpec friendly tags
# @param opts [String] RSpec opts
# @return [String Array] Array of test files
  def get_suites_console(pattern, tags, opts)
    dryrun_output = `rspec #{ (pattern != '') ? "--pattern #{pattern} " : ''}#{tags} #{opts} --dry-run --format json`
    suite_lines = dryrun_output.scan(/"file_path":"\.\/spec.{,150}\.rb"/).uniq
    suite_lines.map do |suite|
      suite.gsub('"file_path":"./', '').gsub('"', '')
    end
  end

# Returns the tests for execution, if executed in RubyMine
# @param pattern [String] Ant pattern to select tests
# @param tags [String] RSpec friendly tags
# @param opts [String] RSpec opts
# @return [String Array] Array of test files
  def get_suites_rubymine(pattern, tags, opts)
    dryrun_output = `rspec #{ (pattern != '') ? "--pattern #{pattern} " : ''} #{tags} #{opts} --dry-run`

    suite_lines = dryrun_output.split("\n").select do |line|
      line if line.include? 'testSuiteStarted name = '
    end

    suites = suite_lines.map do |suite|
      suite = suite.split("' locationHint = '")[1].split("' timestamp = ")[0]
      index = suite.rindex(':')
      suite[0..index - 1]
    end

    suites.uniq! { |suite| suite }

    suites.map { |suite| suite.gsub('file://', '') }
  end

# Returns an array of tests to execute.  Each index represents one forked process.
# @param test_files [String Array] The files to execute
# @param forks [Integer] The number of groups to divide test_files into
# @return [String Array] An array of test files.  Each index is one group.
  def get_test_slices(test_files, forks)
    count = -1
    test_files.group_by {
      count += 1
      count % forks
    }
  end

  # Creates an RSpec Rake Task for unique forks
  #
  # @param index [Integer] The fork index to match the Rake Task
  def create_forked_task(index)
    RSpec::Core::RakeTask.new("spec#{index}", :pattern, :opts) do |t, args|
      t.rspec_opts = args[:opts]
      t.pattern = args[:pattern]
    end
  end

# Creates an RSpec Rake Task for unique forks
#
# @param index [Integer] The fork index to match the Rake Task
  def create_jenkins_forked_task(index)
    RSpec::Core::RakeTask.new("jenkins_spec#{index}", :pattern, :opts) do |t, args|
      t.rspec_opts = args[:opts]  << " --format RspecJunitFormatter --out results/results#{index}.xml"
      t.pattern = args[:pattern]
      t.fail_on_error = false
    end
  end

  # Executes rspec tests in parallel
  #
  # @param test_files_sliced [String Array] The groups of test files to run
  # @param forks [Integer] The number of processes to run in parallel
  # @param temp_files [Tempfile Array] The tempfiles to redirect STDOUT too
  # @param opts [String] RSpec options
  # @return [Integer] Combined exit status of the forks
  def parallel_execution(test_files_sliced, forks, temp_files, opts)
    forks.times do |i|
      fork do
        begin
          puts "Fork #{i} testing: \n\t#{test_files_sliced[i].join("\n\t")}"

          create_forked_task(i)
          redirect_stdout temp_files[i]

          Rake::Task["spec#{i}"].execute({pattern: test_files_sliced[i].join(','), opts: opts})
        rescue => ex
          puts "\n#{ex.message}\n#{ex.backtrace.join("\t\n")}"
        ensure
          $stdout.reopen $initial_stdout #Reset STDOUT
        end
      end
    end
    @status = 0

    Process.waitall.each do |process|
      child_process = process[1].to_s
      @status = child_process.split(' ')[-1].to_i unless child_process.include? 'exit 0'
    end
    @status
  end

# Executes rspec tests in parallel
#
# @param test_files_sliced [String Array] The groups of test files to run
# @param forks [Integer] The number of processes to run in parallel
# @param temp_files [Tempfile Array] The tempfiles to redirect STDOUT too
# @param opts [String] RSpec options
# @return [Integer] Combined exit status of the forks
  def jenkins_parallel_execution(test_files_sliced, forks, temp_files, opts)
    forks.times do |i|
      fork do
        begin
          puts "Fork #{i} testing: \n\t#{test_files_sliced[i].join("\n\t")}"

          create_jenkins_forked_task(i)
          redirect_stdout temp_files[i]

          Rake::Task["jenkins_spec#{i}"].execute({pattern: test_files_sliced[i].join(','), opts: opts})
        rescue => ex
          puts "\n#{ex.message}\n#{ex.backtrace.join("\t\n")}"
        ensure
          $stdout.reopen $initial_stdout #Reset STDOUT
        end
      end
    end
    @status = 0

    Process.waitall.each do |process|
      child_process = process[1].to_s
      @status = child_process.split(' ')[-1].to_i unless child_process.include? 'exit 0'
    end
    @status
  end
end
