ActiveAdmin.register Rayon do
    #filter :City
  #has_and_belongs_to_many :streets
  menu :parent => "City"
  scope :gorod do |rayon|
    rayon.where(:parent =>2775)
  end
  scope :oblast do |rayon|
    rayon.where(:parent =>2902)
  end
  scope :saltovka do |rayon|
    rayon.where(:parent =>2776)
  end
  scope :noviedoma do |rayon|
    rayon.where(:parent =>2778)
  end
  scope :aleks do |rayon|
    rayon.where(:parent =>2833)
  end
  scope :pavl_pole do |rayon|
    rayon.where(:parent =>2832)
  end


end
