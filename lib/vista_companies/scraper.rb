require 'open-uri'

class Scraper

  def self.scrape_all_companies(index_url) #https://www.vistaequitypartners.com/companies/
    company_listing = Nokogiri::HTML(open(index_url))
    companies = []
    company_listing.css("div.all-companies grid3").each do |company|
      company.css("a.grid-item").each do |link|
        company_site = "#{link.attr('href')}"
      end
    end
  end

  def self.scrape_company_page(company_slug)
    company = {}
    company_page = Nokogiri::HTML(open(company_slug))
    details = company_page.css("div.details") #need to go through and find Year of Investment, then take following text, etc.
    company[:year_of_investment] = x
    company[:portfolio_status] = x
    company[:headquarters] = x
    company[:company_site] = company_page.css("div.details a").attr('href')

  end


end
