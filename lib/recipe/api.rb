class Api 

    def self.get_recipes(ingredient)
        #finds the ingredient in the API
        url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=#{ingredient}"
        #stringifies the ingredient information
        response = Net::HTTP.get(URI(url))
        #parses the ingredient information into a hash -- meals in the key attached to everything
        recipes = JSON.parse(response)["meals"]
        #creates new ingredient
        new_ingredient = Ingredient.new(ingredient)
        #could create attribute hash
        if !recipes.nil?
          recipes.each do |r| 
            new_recipe = Recipe.new(name: r["strMeal"], recipe_id: r["idMeal"], ingredient: ingredient)
            #pushes the recipe object into an array of recipes containing the ingredient
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

end 