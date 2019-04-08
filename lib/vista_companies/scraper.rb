require 'open-uri'
require 'openssl'
require 'nokogiri'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class Scraper

  def self.scrape_all_companies(index_url)
    company_listing = Nokogiri::HTML(open(index_url))
    companies = []
    company_listing.css("div.all-companies.grid3").each do |company|
      company.css(".grid-item").each do |card|
      company_site = card.attribute("href").value
      company_name = card.css("div.table-cell img").attribute('alt').text.gsub(" Logo","")
      companies << {link_detail: company_site, company_name: company_name}
      end
    end
    companies
    binding.pry
  end

  def self.scrape_company_page(company_slug)
    company = {}
    company_page = Nokogiri::HTML(open(company_slug))
    company[:year_of_investment] = company_page.css("div.details").text.split("\n")[4].strip
    company[:portfolio_status] = company_page.css("div.details").text.split("\n")[6].strip
    company[:headquarters] = company_page.css("div.details").text.split("\n")[11].strip
    company[:company_site] = company_page.css("div.details a").attribute('href').value
    company[:brief_desc] = company_page.css("div.comp-content.inline-block p strong").text
    company[:detail_desc] = company_page.css("div.comp-content.inline-block p").slice(1,100).text
    company
  end

end
