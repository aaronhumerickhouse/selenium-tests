require_relative './../spec/default_watir'
require_relative './../pages/hq/tournament/tournament_page.rb'
require_relative './../helpers/tournament/tournament_helper.rb'

#Deletes all tournaments that include a value passed in via command line argument.
class CleanupTournament
  $LOGGER = TournamentHelper.create_logger
  begin
    $browser = SportNginWatir::Browser.new :firefox
    DefaultTournamentHelper.go_to_tournament
    LoginHelper.login

    tournament_page = TournamentPage.new($browser)
    search_phrase = ARGV[0]
    $browser.wait_until { tournament_page.tournament_table_element.exists? }
    $LOGGER.info "Searching for #{search_phrase}"
    tournament_page.search_element.when_visible.value = search_phrase
    tournament_page.search_icon_element.click
    $browser.wait_until { tournament_page.tournament_table_element.exists? }

    $browser.wait_until { tournament_page.tournament_table? }
    while tournament_page.tournament_table_element[1].when_present.exists?
      begin
        TournamentHelper.delete_first_row

        unless tournament_page.tournament_table_element[1].exists?
          $browser.refresh
          $browser.wait_until(60) { !tournament_page.tournament_spinner_element.visible? }
          if tournament_page.empty_tournament_results?
            break
          end
        end
        $browser.wait_until { tournament_page.tournament_table? }
      rescue => ex
        $browser.close
        puts ex
        puts ex.backtrace
      end
    end
    $browser.close
  end
end
