class PortCo

  attr_accessor :link_detail, :industry, :company_name, :year_of_investment, :portfolio_status, :headquarters, :company_site, :brief_desc, :detail_desc

  @@all = []

  def initialize(company_hash)
    company_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    @@all << self
  end

  def self.create_from_all_companies_page(companies_array)
    companies_array.each do |company_hash|
      PortCo.new(company_hash)
  end

  def add_company_attributes(attributes_hash)
    attributes_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    self
  end

  def self.all
    @@all
  end

end
