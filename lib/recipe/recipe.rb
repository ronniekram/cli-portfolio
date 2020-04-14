class Recipe 
    attr_accessor :name, :recipe_id, :ingredient, :instructions, :ingredients, :measures, :cuisine 

    @@all = []

    def initialize(name:, recipe_id:, ingredient:)
        @name = name 
        @recipe_id = recipe_id
        @ingredient = ingredient
        @ingredients = []
        @measures = []
        @cuisine = cuisine  
        @@all << self 
    end
    
    def self.all
        @@all  
    end
end 