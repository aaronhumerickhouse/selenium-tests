require 'rubygems'
require 'rspec/core/rake_task'
require 'rufus-scheduler'
require_relative 'utilities/utilities'
require_relative 'resources/rake/utilities'

include RakeUtilities

SPACING = '==================================================================='
MAX_SAUCE_NODES = 10

desc 'Runs Selenium Tests locally'
RSpec::Core::RakeTask.new(:spec, [:pattern, :opts]) do |t, args|
  t.pattern = args[:pattern] unless args[:pattern] == ''
  t.rspec_opts = args[:opts]
end


desc 'Runs Selenium Tests on Jenkins - JUnit formatting'
RSpec::Core::RakeTask.new(:jenkins_spec, [:pattern, :opts]) do |t, args|
  t.pattern = args[:pattern] unless args[:pattern] == ''
  t.rspec_opts = args.opts << ' --format RspecJunitFormatter' << ' --out results/results.xml'
  t.fail_on_error = false
end


desc 'Runs Selenium Tests in Parallel, args: <ANT PATTERN>, <SPEC TAGS>, <NUMBER OF FORKS>, <RSPEC_OTS>'
task :parallel_spec, [:pattern, :tags, :forks, :opts] do |t, args|
  tags = get_tags(args[:tags])
  test_files = get_suites(args[:pattern], tags, args[:opts])

  if test_files.size == 0
    warn "No tests found with pattern [#{args[:pattern]}] and tags [#{args[:tags]}]"
    exit 1
  else
    puts 'Test Files:'
    puts test_files.join("\n")
  end

  forks = get_forks(args[:forks].to_i, test_files.size)
  test_files_sliced = get_test_slices(test_files, forks)
  temp_files = Array.new(forks) { Tempfile.new('temp_output') }

  scheduler = Rufus::Scheduler.new
  scheduler.every '5m' do
    puts "Executing Tests#{' in Sauce Labs' if Utilities.is_sauce?}.  Output will be displayed when finished."
  end

  status = parallel_execution(test_files_sliced, forks, temp_files, args[:opts])

  scheduler.shutdown
  puts friendly_output(test_files_sliced, temp_files)
  exit 1 unless status == 0
end

desc 'Runs Selenium Tests on Jenkins - JUnit formatting'
task :jenkins_spec, [:pattern, :tags, :forks, :opts] do |t, args|
  args[:opts] << ' --format RspecJunitFormatter' << ' --out results/results.xml'
  Rake::Task['parallel_spec'].execute({pattern: args[:pattern], tags: args[:tags], forks: args[:forks], opts: "#{args[:opts]} --format RspecJunitFormatter --out results/results.xml"})
end

desc 'Runs Selenium Tests in Parallel, args: <ANT PATTERN>, <SPEC TAGS>, <NUMBER OF FORKS>, <RSPEC_OTS>'
task :jenkins_parallel_spec, [:pattern, :tags, :forks, :opts] do |t, args|
  tags = get_tags(args[:tags])
  test_files = get_suites(args[:pattern], tags, args[:opts])

  if test_files.size == 0
    warn "No tests found with pattern [#{args[:pattern]}] and tags [#{args[:tags]}]"
    exit 1
  end

  forks = get_forks(args[:forks].to_i, test_files.size)
  test_files_sliced = get_test_slices(test_files, forks)
  temp_files = Array.new(forks) { Tempfile.new('temp_output') }

  scheduler = Rufus::Scheduler.new
  scheduler.every '5m' do
    puts "Executing Tests#{' in Sauce Labs' if Utilities.is_sauce?}.  Output will be displayed when finished."
  end

  status = jenkins_parallel_execution(test_files_sliced, forks, temp_files, args[:opts])

  scheduler.shutdown
  puts friendly_output(test_files_sliced, temp_files)
  exit 1 unless status == 0
end
