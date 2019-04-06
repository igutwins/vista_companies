Learn CLI Gem Project

Source:
https://www.vistaequitypartners.com/companies/

Functionality

Scrape all companies on the page, both current and former

Attributes to include from first level:
link_detail:
industry: [ntd: how to get at this - it's just in the CSS class?]

Attributes to include from second level: [NTD: this is the 'one level deep" requirement
company_name:
year_of_investment:
portfolio_status:
Headquarters:
company_site:
brief_desc:
detail_desc:

CLI application should:

Welcome user. Explain the program.
Offer 1 for current, 2 for former, or 3 for all, alphabetically, or 4 for by industry

If 1, 2 or 3
List out company names with a number
then list out details of an individual company if a user inputs the number
Some further prompt for "more detail"

If 4,
List out all the industry categorizations with numbers
prompt user for input of a number
then list out all companies in that industry

class Company
attr_accessor :company_name, :portfolio_status, :headquarters, :company_site, :brief_desc, :detail_desc:
@@all = []

def initialize
@@all << self
end

end

class scraper
end
