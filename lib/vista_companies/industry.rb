class Industry
  attr_accessor :ind_name
  attr_reader :portcos

  @@all = []

    def initialize(ind_name)
      @ind_name = ind_name
      @portcos = []
    end

    def self.find_by_name(name)
      self.all.detect{|i| i.ind_name == name}
    end

    def self.find_or_create_by_name(name)
      self.find_by_name(name) || self.create(name)
    end

    def self.create(name)
      name = "Other" if name == ""
      industry = Industry.new(name)
      industry.save
      industry
    end

    def save
      self.class.all << self
    end

    def self.all
      @@all
    end

    def self.destroy_all
      all.clear
    end
end
