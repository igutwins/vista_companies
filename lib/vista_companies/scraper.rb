require 'open-uri'

class Scraper

  def self.scrape_all_companies(index_url)
    company_listing = Nokogiri::HTML(open(index_url))
    companies = []
    company_listing.css("div.all-companies grid3").each do |company|
        company_site = company.attr('href').value
        company_name = company.attr('alt').text
        companies << {link_detail: company_site}
      end
    end
  end

  def self.scrape_company_page(company_slug)
    company = {}
    company_page = Nokogiri::HTML(open(company_slug))
    details = company_page.css("div.details")
    #need to go through and find Year of Investment, then take following text, etc.
    company[:year_of_investment] = details[2].text
    company[:portfolio_status] = details[4].text
    company[:headquarters] = details[6].text
    company[:company_site] = company_page.css("div.details a").attr('href')
    company[:brief_desc] = company_page.css("div.comp-content.inline-block p strong").text
    company[:detail_desc] = company_page.css("div.comp-content.inline-block p").text

    company

  end


end
