require 'rspec'

# A single soft assert that holds an exception and a screenshot location
class SoftAssert
  #The exception to handle and output later
  attr_accessor :exception
  #The screenshot file string
  attr_accessor :screenshot
  #The url at point of failure
  attr_accessor :url
  #A custom message to be included on any verification
  attr_accessor :message

  #Initializes a SoftAssert
  #
  # *Parameters:*
  # *  +exception+ - The exception of the verification
  def initialize(exception)
    @exception = exception
  end


#Prints a friendly format of a soft_assert exception
#
# *Parameters:*
# *  +soft_assert+ - The soft_assert object to print
# *Returns:*
# *  A print friendly version of the exception message and backtrace
  def print_friendly_exception
    output = ''
    output = "Message: #{@message}\n" if @message
    output += "Exception: #{@exception.message}\n"
    output += @exception.backtrace.join("\n")
    output += "\nURL: #{@url}"
    output += "\nScreenshot:\n"
    output += "<img src=\"file://#{@screenshot}\" height=\"50%\" width=\"50%\"></img>"
    output += "\n---------------------------------------------------------------------------------\n\n"

    return output
    end
end

# Used to avoid hard asserts, which fail tests the instant an expectation is not met.  This way we can verify
# multiple things throughout a test while completing an entire test.
#
# Example:
#  soft_asserts = SoftAsserts.new
#  soft_asserts.verify {expect(one).to eq(2)} #expectation not met
#  soft_asserts.verify {expect(three).to eq(3)} #expectation met
#  soft_asserts.release</tt> <- would raise an ExpectationNotMetError if one != 2
#  Without SoftAsserts, the second Expectation would not be executed.
class SoftAsserts
  public
  #The list of soft_asserts
  attr_accessor :soft_asserts

  #Initializes soft_asserts with an empty list
  def initialize
    @soft_asserts = []
  end

  # Executes an RSpec expectation from a and adds an ExpectationNotMetError to the list if one is raised allowing
  # the test to continue
  #
  # *Parameters:*
  # *  +message+ - A message custom to a verification
  # Example:
  #  soft_asserts = SoftAsserts.new
  #  soft_asserts.verify {expect(one).to eq(1)}
  #  soft_asserts.verify("The variable 'one' is not equal to 1") {expect(one).to eq(1)}
  def verify(message=nil)
    begin
      yield
    rescue RSpec::Expectations::ExpectationNotMetError => ex
      soft_assert = SoftAssert.new(ex)
      soft_assert.screenshot = Utilities.create_screenshot('soft_asserts')
      soft_assert.url = $browser.url
      soft_assert.message = message if message
      @soft_asserts.push(soft_assert)
    end
  end

  # To be executed at the end of a test, raises an ExpectationNotMetError and outputs any collected
  # ExpectationNotMetErrors
  #
  # Example:
  #  soft_asserts = SoftAsserts.new
  #  soft_asserts.verify {expect(one).to eq(2)}
  #  soft_asserts.release # <- would raise an ExpectationNotMetError if one != 2
  def release
    unless @soft_asserts.empty?
      if ARGV.any? { |arg| arg == 'h' || arg == 'html' }
        @soft_asserts.each { |soft_assert|
          output = "<div style=\"border:5px solid #C20000; border-radius: 25px; padding:20px;\">"
          output += "<dd class=\"example failed\"><h2>Assertion Failure</h2><pre>"
          output += "Message: #{soft_assert.message}"
          exception = soft_assert.exception
          output += exception.message
          output += exception.backtrace.select { |item| item.include? 'selenium-tests' }.join("\n")
          output += '</pre></dd>'
          output += "\nURL: #{soft_assert.url}\n"
          output += 'Screenshot: '
          output += "<br><img src=\"file://#{soft_assert.screenshot}\" width=\"50%\" height=\"50%\"></img><br><br>"
          output += '<b>See full trace below.</b></div><br><br>'
          puts output
        }
      end
      raise RSpec::Expectations::ExpectationNotMetError, generate_message
    end
  end

  #Checks to see if the list of soft_asserts is empty
  #
  # *Returns:*
  # * True if the list is empty
  # * False if the list is empty
  def empty?
    @soft_asserts.empty?
  end

  private

  # Iterates through the list of failures and outputs them in a friendly fashion
  #
  # *Returns:*
  # *  The print out of all failures as a string
  def generate_message
    print_out = ''
    @soft_asserts.each { |soft_assert|
      print_out << soft_assert.print_friendly_exception
    }
    print_out
  end
end
