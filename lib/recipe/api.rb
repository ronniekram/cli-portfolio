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
        end
    end 

    def self.get_recipe_info(recipe)
        url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{recipe.recipe_id}"
        response = Net::HTTP.get(URI(url))
        info = JSON.parse(response)["meals"][0]
        populate_recipe(info, recipe)
    end
    
    def self.get_random
        url = "https://www.themealdb.com/api/json/v1/1/random.php"
        response = Net::HTTP.get(URI(url))
        random = JSON.parse(response)["meals"][0]
        if Recipe.find_by_name(random["strMeal"])
            Recipe.find_by_name(random["strMeal"])
        else
          new_recipe = Recipe.new(name: random["strMeal"], recipe_id: random["idMeal"])
          populate_recipe(random, new_recipe)
          new_recipe
        end
    end 

    def self.populate_recipe(info, recipe)
        recipe.instructions = info["strInstructions"]
        recipe.cuisine = info["strArea"]
        
        info.keys.each do |k|
            recipe.ingredients << info[k] if (k.include? "Ingredient") && info[k] && info[k] != ""
            recipe.measures << info[k] if (k.include? "Measure") && info[k] && info[k] != ""
        end
    end 

end 