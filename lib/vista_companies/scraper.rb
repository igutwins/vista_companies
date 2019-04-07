require 'open-uri'

class Scraper

  def self.scrape_company_page(index_url) #https://www.vistaequitypartners.com/companies/
    company_page = Nokogiri::HTML(open(index_url))
    companies = []
    company_page.css("div.all-companies grid3")

  end


end
