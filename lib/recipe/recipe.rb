class Recipe 
    attr_accessor :name, :recipe_id, :ingredient. :recipe_detail
    @@all = []

    def initialize(name:, recipe_id:, ingredient:)
        @name = name 
        @recipe_id = recipe_id
        @ingredient = ingredient
        @@all << self
    end
    
    def self.all
        @@all  
    end
    
    def self.find_by_ingredient(ingredient)
        @@all.select {|r| r.ingredient == ingredient}
    end 
end 
