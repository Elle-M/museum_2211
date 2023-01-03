class Museum
  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name     = name
    @exhibits = []
    @patrons  = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    patron.interests
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    # { 
    #   "Dead Sea Scrolls" => [:patron_1, :patron_3],
    #   "Gems and Minderals" => [:patron_1],
    #   "Imax" => [:patron_2] }

  end
end