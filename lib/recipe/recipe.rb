class Recipe 
    attr_accessor :name, :recipe_id, :ingredient, :instructions, :ingredients, :measures, :cuisine

    @@all = []

    def initialize(name:, recipe_id:, ingredient: nil)
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

    def self.find_by_name(name)
        @@all.find {|recipe| recipe.name == name}
    end 
end 