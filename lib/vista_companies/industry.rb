class Industry
attr_accessor :ind_name
attr_reader :portcos

@@all = []

  def initalize(ind_name)
    @ind_name = ind_name
    @portcos = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
      self.class.all << self
  end

  def self.save(ind_name)
    new.ind_name.tap( |x| x.save )
  end

end
