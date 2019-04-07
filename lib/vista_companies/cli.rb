#CLI Controller
class VistaCompanies::CLI
  BASE_PATH = "https://www.vistaequitypartners.com/companies/"
  def call
    greeting
    list
    input = nil
    while input != "exit"
      puts "Type 'list' to repeat the list of options or type 'exit' to leave the program."
    input = gets.strip.downcase
      case input
        when "1"
          puts "All current portfolio companies alphabetically." #data goes here
        when "2"
          puts "All former portfolio companies alphabetically."
        when "3"
          puts "All portfolio companies alphabetically."
        when "4"
          puts "All industry classifications"
        when "list"
          list
        when "exit"
          goodbye
        else
          puts "Invalid entry. Type 'list' to repeat the list of options or type 'exit' to leave the program."
        end
      end
  end

  def greeting
    puts "Welcome to the private equity fund portfolio company scraper."
    puts "This program allows users to navigate Vista Equity Partners' current and former investments."
    puts "You can navigate the program in the following ways:"
  end

  def list
    puts "1. Enter '1' to list all current portfolio companies alphabetically."
    puts "2. Enter '2' to list all former portfolio companies alphabetically."
    puts "3. Enter '3' to list all portfolio companies alphabetically (whether current or former)."
    puts "4. Enter '4' to select companies by industry classification."
  end

  def goodbye
    puts "Goodbye."
  end

end

#Welcome user. Explain the program.
#Offer 1 for current, 2 for former, or 3 for all, alphabetically, or 4 for by industry

#If 1, 2 or 3
#List out company names with a number
#then list out details of an individual company if a user inputs the number
#Some further prompt for "more detail"

#If 4,
#List out all the industry categorizations with numbers
#prompt user for input of a number
#then list out all companies in that industry
