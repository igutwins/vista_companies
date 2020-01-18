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
          when "2" #lists former
          display_all_former
          input_prompt
        when "3" #lists all
          display_all_comps
          input_prompt
          input = nil
          while input != "exit"
            input = gets.to_i - 1
            all_sorted = PortCo.all.sort_by {|company| company.company_name}
            puts "#{all_sorted[input].company_name}"
            puts "Type 'list' to repeat the list of options or type 'exit' to leave the program."
          end
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
    all_current = PortCo.all.select {|company| company.portfolio_status == "Current"}
    sorted = all_current.sort_by {|company| company.company_name}
    sorted.each_with_index do |company, index|
      puts "##{index+1}. #{company.company_name.upcase}".colorize(:red)
    end
    puts
  end

  def display_all_former
    all_former = PortCo.all.select {|company| company.portfolio_status == "Former"}
    sorted = all_former.sort_by {|company| company.company_name}
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

  def display_selected_company(user_input)
      selected = PortCo.all[input-1]
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
