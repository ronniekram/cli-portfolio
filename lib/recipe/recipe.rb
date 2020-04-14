class Recipe 
    attr_accessor :name, :recipe_id, :ingredient, :instructions 

    @@all = []

    def initialize(name:, recipe_id:, ingredient:)
        @name = name 
        @recipe_id = recipe_id
        @ingredient = ingredient
        #@instructions = instructions  
        @@all << self 
    end
    
    def self.all
        @@all  
    end
    
    def self.find_by_ingredient(ingredient)
        @@all.select {|r| d.ingredient == ingredient}
    end 
end 