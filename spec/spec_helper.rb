require_relative '../utilities/utilities'
require 'headless'
require_relative '../helpers/default_watir'

RSpec.configure do |config|
  config.before(:all) do
    begin
      ENV['SPEC_TYPE'] = 'TOURNAMENT' if config.files_to_run.inspect.include? 'hq/tournament'
      default_timeout = 20
      Utilities.is_tournament? ? Watir.default_timeout = default_timeout : SportNginWatir.default_timeout = default_timeout
      $has_errors = false
      $LOGGER = Utilities.create_logger
      @test_name = self.class.to_s.split('::')[-1]
      $LOGGER.info("\n\n----------Starting test: #{@test_name}----------")

      $browser = DefaultWatir.initiate_browser(self.class.file_path.split('/')[-1].split('.rb')[0])
      @session_id = $browser.driver.capabilities['webdriver.remote.sessionid'] if Utilities.is_sauce?
    rescue => ex
      $has_errors = true
      raise ex
    end
  end

  config.before(:each) do |example|
    $LOGGER.info "------------ Starting '#{example.example_group.description} #{example.description}'-----------"
    @soft_asserts = SoftAsserts.new
  end

  config.after(:each) do |example|
    Utilities.create_exception_screenshot(example)

    unless $has_errors
      $has_errors = true unless @soft_asserts.empty?
    end
    @soft_asserts.release

    $LOGGER.info "------------ Ending #{example.example_group.description} #{example.description}-----------"
  end

  config.after(:all) do
    if @tournament_data
      tournament_name = @tournament_data[:name]
      begin
        TournamentHelper.delete_tournament(tournament_name)
      rescue => ex
        puts "Failed to delete tournament: #{tournament_name}"
        puts ex.message
        puts ex.backtrace.join("\t\n")
      end
    end
    $LOGGER.info "----------Ending test: #{@test_name}----------"
    puts "\n\n"

    $browser.close if $browser
    SauceHelper.update_status(@session_id, $has_errors) if Utilities.is_sauce?
  end
end


