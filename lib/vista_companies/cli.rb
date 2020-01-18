#CLI Controller
class VistaCompanies::CLI
  def call
    greeting
    make_companies
    add_company_attributes
    list
    input = nil
    while input != "exit"
      puts "Type 'list' to repeat the list of options or type 'exit' to leave the program."
      input = gets.strip.downcase
      case input
        when "1" #lists current
          display_all_current
          input_prompt
          user_input = gets.to_i
          display_selected_current_company(user_input)
        when "2" #lists former
          display_all_former
          input_prompt
          user_input = gets.to_i
          display_selected_former_company(user_input)
        when "3" #lists all
          display_all_comps
          input_prompt
          user_input = gets.to_i
          display_selected_company(user_input)
        when "4"
          puts "All industry classifications" #this needs work!
          input_prompt
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
    puts "This program lets users navigate Vista Equity Partners' portfolio of current and former investments."
    puts "Please wait while the program scrapes Vista's current webpage...\n\n"
  end

  def list
    puts "You can navigate the program in the following ways:\n\n"
    puts "1. Enter '1' to list all current portfolio companies alphabetically."
    puts "2. Enter '2' to list all former portfolio companies alphabetically."
    puts "3. Enter '3' to list all portfolio companies alphabetically (whether current or former)."
    puts "4. Enter '4' to select companies by industry classification.\n\n"
  end

  def goodbye
    puts "Goodbye."
  end

  def input_prompt
    puts "Please enter the company number for more information."
    puts "Or type 'list' to repeat the list of options or type 'exit' to leave the program."
  end

  def make_companies
    companies_array = Scraper.scrape_all_companies('https://www.vistaequitypartners.com/companies')
    PortCo.create_from_all_companies_page(companies_array)
  end

  def add_company_attributes
    PortCo.all.each do |company|
      attributes = Scraper.scrape_company_page(company.link_detail)
      company.add_company_attributes(attributes)
    end
  end

  def display_all_current
    current = PortCo.all_current
    sorted = current.sort_by {|company| company.company_name}
    sorted.each_with_index do |company, index|
      puts "##{index+1}. #{company.company_name.upcase}".colorize(:red)
    end
    puts
  end

  def display_all_former
    former = PortCo.all_former
    sorted = former.sort_by {|company| company.company_name}
    sorted.each_with_index do |company, index|
      puts "##{index+1}. #{company.company_name.upcase}".colorize(:red)
    end
    puts
  end

  def display_all_comps
    all_comps = PortCo.all
    sorted = all_comps.sort_by {|company| company.company_name}
    sorted.each_with_index do |company, index|
      puts "##{index+1}. #{company.company_name.upcase}".colorize(:red)
    end
    puts
  end

  def display_selected_current_company(user_input)
      input = user_input
      selected = PortCo.all_current[input]
      puts "#{selected.company_name.upcase}".colorize(:red)
      puts "  Year of Investment:".colorize(:light_blue) + " #{selected.year_of_investment}"
      puts "  Portfolio Status:".colorize(:light_blue) + " #{selected.portfolio_status}"
      puts "  Headquarters:".colorize(:light_blue) + " #{selected.headquarters}"
      puts "  Website:".colorize(:light_blue) + " #{selected.company_site}"
      puts "  Description:".colorize(:light_blue) + " #{selected.brief_desc}"
      puts "  Website:".colorize(:light_blue) + " #{selected.company_site}"
      puts "----------------------".colorize(:green)
  end

  def display_selected_former_company(user_input)
      input = user_input - 1
      selected = PortCo.all_former[input]
      puts "#{selected.company_name.upcase}".colorize(:red)
      puts "  Year of Investment:".colorize(:light_blue) + " #{selected.year_of_investment}"
      puts "  Portfolio Status:".colorize(:light_blue) + " #{selected.portfolio_status}"
      puts "  Headquarters:".colorize(:light_blue) + " #{selected.headquarters}"
      puts "  Website:".colorize(:light_blue) + " #{selected.company_site}"
      puts "  Description:".colorize(:light_blue) + " #{selected.brief_desc}"
      puts "  Website:".colorize(:light_blue) + " #{selected.company_site}"
      puts "----------------------".colorize(:green)
  end

  def display_selected_company(user_input)
      input = user_input - 1
      selected = PortCo.all[input]
      puts "#{selected.company_name.upcase}".colorize(:red)
      puts "  Year of Investment:".colorize(:light_blue) + " #{selected.year_of_investment}"
      puts "  Portfolio Status:".colorize(:light_blue) + " #{selected.portfolio_status}"
      puts "  Headquarters:".colorize(:light_blue) + " #{selected.headquarters}"
      puts "  Website:".colorize(:light_blue) + " #{selected.company_site}"
      puts "  Description:".colorize(:light_blue) + " #{selected.brief_desc}"
      puts "  Website:".colorize(:light_blue) + " #{selected.company_site}"
      puts "----------------------".colorize(:green)
  end

end
