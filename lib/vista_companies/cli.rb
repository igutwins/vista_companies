class VistaCompanies::CLI
  def call
    greeting
    make_companies
    add_company_attributes
    sort_to_industry
    list
    input = nil
    while input != "exit"
      puts "Type 'list' to repeat the list of options or type 'exit' to leave the program.\n\n".colorize(:light_magenta)
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
          display_all_industries
          input_prompt_industry
          user_input = gets.to_i
          display_selected_industry(user_input)
          puts "\n\n"
        when "list"
          list
        when "exit"
          goodbye
        else
          puts "Invalid entry. Type 'list' to repeat the list of options or type 'exit' to leave the program.\n\n".colorize(:light_magenta)
        end
      end
    end

  def greeting
    puts "\n"
    puts "Welcome to the private equity fund portfolio company scraper.".colorize(:light_magenta)
    puts "\n"
    puts "This program lets users navigate Vista Equity Partners' portfolio of current and former investments.".colorize(:light_magenta)
    puts "Please wait while the program scrapes Vista's current webpage...\n\n".colorize(:light_magenta)
  end

  def list
    puts "You can navigate the program in the following ways:\n\n".colorize(:light_magenta)
    puts "1. Enter '1' to list all current portfolio companies alphabetically.".colorize(:white)
    puts "2. Enter '2' to list all former portfolio companies alphabetically.".colorize(:white)
    puts "3. Enter '3' to list all portfolio companies alphabetically (whether current or former).".colorize(:white)
    puts "4. Enter '4' to select companies by industry classification.\n\n".colorize(:white)
  end

  def goodbye
    puts "\n\n"
    puts "Goodbye.".colorize(:yellow)
    puts "\n\n"
  end

  def input_prompt
    puts "Please enter the company number for more information.".colorize(:light_magenta)
    puts "Or type 'list' to repeat the list of options or type 'exit' to leave the program.\n\n".colorize(:light_magenta)
  end

  def input_prompt_industry
    puts "Please enter the industry number for a list of Vista's portfolio companies in that industry.".colorize(:light_magenta)
    puts "Or type 'list' to repeat the list of options or type 'exit' to leave the program.\n\n".colorize(:light_magenta)
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

  def sort_to_industry
    PortCo.all.each do |company|
      industry = company.industry
      industry.portcos << company.company_name
    end
  end

  def display_all_current
    puts "\n"
    puts "----------------------".colorize(:green)
    current = PortCo.all_current
    sorted = current.sort {|a,b| a.company_name.downcase <=> b.company_name.downcase}
    sorted.each_with_index do |company, index|
      puts "##{index+1}. #{company.company_name.upcase}".colorize(:red)
    end
    puts "----------------------".colorize(:green)
    puts "\n"
  end

  def display_all_former
    puts "\n"
    puts "----------------------".colorize(:green)
    former = PortCo.all_former
    sorted = former.sort {|a,b| a.company_name.downcase <=> b.company_name.downcase}
    sorted.each_with_index do |company, index|
      puts "##{index+1}. #{company.company_name.upcase}".colorize(:red)
    end
    puts "----------------------".colorize(:green)
    puts "\n"
  end

  def display_all_comps
    puts "\n"
    puts "----------------------".colorize(:green)
    all_comps = PortCo.all
    sorted = all_comps.sort {|a,b| a.company_name.downcase <=> b.company_name.downcase}
    sorted.each_with_index do |company, index|
      puts "##{index+1}. #{company.company_name.upcase}".colorize(:red)
    end
    puts "----------------------".colorize(:green)
    puts "\n"
  end

  def display_all_industries
    puts "\n"
    puts "----------------------".colorize(:green)
    all_industries = Industry.all
    sorted = all_industries.sort_by {|industry| industry.ind_name.downcase}
    sorted.each_with_index do |industry, index|
      puts "##{index+1}. #{industry.ind_name.upcase}".colorize(:red)
    end
    puts "----------------------".colorize(:green)
    puts "\n"
  end

  def display_selected_current_company(user_input)
      input = user_input - 1
      selected = PortCo.all_current.sort {|a,b| a.company_name.downcase <=> b.company_name.downcase}[input]
      puts "\n"
      puts "----------------------".colorize(:green)
      puts "#{selected.company_name.upcase}".colorize(:red)
      puts "  Year of Investment:".colorize(:light_blue) + " #{selected.year_of_investment}"
      puts "  Portfolio Status:".colorize(:light_blue) + " #{selected.portfolio_status}"
      puts "  Headquarters:".colorize(:light_blue) + " #{selected.headquarters}"
      puts "  Website:".colorize(:light_blue) + " #{selected.company_site}"
      puts "  Industry:".colorize(:light_blue) + " #{selected.industry.ind_name}"
      puts "  Description:".colorize(:light_blue) + " #{selected.brief_desc}"
      puts "  Website:".colorize(:light_blue) + " #{selected.company_site}"
      puts "----------------------".colorize(:green)
      puts "\n"
  end

  def display_selected_former_company(user_input)
      input = user_input - 1
      selected = PortCo.all_former.sort {|a,b| a.company_name.downcase <=> b.company_name.downcase}[input]
      puts "\n"
      puts "----------------------".colorize(:green)
      puts "#{selected.company_name.upcase}".colorize(:red)
      puts "  Year of Investment:".colorize(:light_blue) + " #{selected.year_of_investment}"
      puts "  Portfolio Status:".colorize(:light_blue) + " #{selected.portfolio_status}"
      puts "  Headquarters:".colorize(:light_blue) + " #{selected.headquarters}"
      puts "  Website:".colorize(:light_blue) + " #{selected.company_site}"
      puts "  Industry:".colorize(:light_blue) + " #{selected.industry.ind_name}"
      puts "  Description:".colorize(:light_blue) + " #{selected.brief_desc}"
      puts "  Website:".colorize(:light_blue) + " #{selected.company_site}"
      puts "----------------------".colorize(:green)
      puts "\n"
  end

  def display_selected_company(user_input)
      input = user_input - 1
      selected = PortCo.all.sort {|a,b| a.company_name.downcase <=> b.company_name.downcase}[input]
      puts "\n"
      puts "----------------------".colorize(:green)
      puts "#{selected.company_name.upcase}".colorize(:red)
      puts "  Year of Investment:".colorize(:light_blue) + " #{selected.year_of_investment}"
      puts "  Portfolio Status:".colorize(:light_blue) + " #{selected.portfolio_status}"
      puts "  Headquarters:".colorize(:light_blue) + " #{selected.headquarters}"
      puts "  Website:".colorize(:light_blue) + " #{selected.company_site}"
      puts "  Industry:".colorize(:light_blue) + " #{selected.industry.ind_name}"
      puts "  Description:".colorize(:light_blue) + " #{selected.brief_desc}"
      puts "  Website:".colorize(:light_blue) + " #{selected.company_site}"
      puts "----------------------".colorize(:green)
      puts "\n"
  end

  def display_selected_industry(user_input)
      input = user_input - 1
      all_industries = Industry.all
      sorted = all_industries.sort_by {|industry| industry.ind_name.downcase}
      selected = sorted[input]
      puts "\n"
      puts "Below are all of Vista's current or former investments in the #{selected.ind_name} industry:".colorize(:light_magenta)
      puts "\n"
      puts "----------------------".colorize(:green)
      selected.portcos.each_with_index do |company, index|
        puts "##{index+1}. #{company.upcase}".colorize(:red)
      end
      puts "----------------------".colorize(:green)
  end
end
