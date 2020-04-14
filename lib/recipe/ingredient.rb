class Ingredient
    #has-many relationship
    attr_accessor :name, :recipes
    
    @@all = []
    
    def initialize(name)
        @name = name
        @recipes = []
        @@all << self
    end
    
    def self.all
        @@all  
    end
    
    def self.find_by_ingredient(ingredient)
        @@all.find {|i| i.name == ingredient}
        #if not found, will return nil
    end 
end 