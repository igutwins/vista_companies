class Industry
attr_accessor :ind_name
attr_reader :portcos

@@all = []

  def initialize(ind_name)
    @ind_name = ind_name
    @portcos = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

end
