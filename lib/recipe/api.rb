class Api 

    def self.get_recipes(ingredient)
        url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=#{ingredient}"
        response = Net::HTTP.get(URI(url))
        recipes = JSON.parse(response)["meals"]
        new_ingredient = Ingredient.new(ingredient)
        if !recipes.nil?
          recipes.each do |r| 
            new_recipe = Recipe.new(name: r["strMeal"], recipe_id: r["idMeal"], ingredient: ingredient)
            new_ingredient.recipes << new_recipe
          end
        else 
            puts " "  
        end
    end 

    def self.get_recipe_info(recipe)
        url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{recipe.recipe_id}"
        response = Net::HTTP.get(URI(url))
        info = JSON.parse(response)["meals"][0]
        recipe.instructions = info["strInstructions"]
        recipe.cuisine = info["strArea"]
        
        info.keys.each do |k|
            recipe.ingredients << info[k] if (k.include? "Ingredient") && info[k]
            recipe.measures << info[k] if (k.include? "Measure") && info[k]
            recipe.cuisine << info[k] if (k.include? "Area") && info[k]
        end
    end
    
    def self.get_random
        url = "https://www.themealdb.com/api/json/v1/1/random.php"
        response = Net::HTTP.get(URI(url))
        random = JSON.parse(response)["meals"]
    end 

end 