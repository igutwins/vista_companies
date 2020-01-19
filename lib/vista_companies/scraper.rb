require 'open-uri'

class Scraper

  def self.scrape_all_companies(index_url)
    company_listing = Nokogiri::HTML(open(index_url))
    companies = []
    company_listing.css("div.all-companies.grid3").each do |company|
      company.css(".grid-item").each do |card|
        company_site = card.attribute("href")
        company_name = card.css("div.table-cell img").attribute('alt').text.gsub(" Logo","")
        industry = card[:class].split(" ").detect { |x| x.include?("industry")}
        industry_clean = Industry.new(industry.gsub("industry-","").gsub("-"," ").capitalize)
        companies << {link_detail: company_site, company_name: company_name, industry: industry_clean}
      end
    end
    companies
  end

  def self.scrape_company_page(company_slug)
    company = {}
    company_page = Nokogiri::HTML(open(company_slug))
    company[:year_of_investment] = company_page.css("div.details").text.split("\n")[4].strip
    company[:portfolio_status] = company_page.css("div.details").text.split("\n")[6].strip
    company[:headquarters] = company_page.css("div.details").text.split("\n")[11].strip
    company[:company_site] = company_page.css("div.details a").attribute('href')
    company[:brief_desc] = company_page.css("div.comp-content.inline-block p")[0].text
    company[:detail_desc] = company_page.css("div.comp-content.inline-block p").slice(1,100).text
    company
  end

end
