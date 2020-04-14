class Api

    def self.get_recipe(input)
        url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=#{input}"
        response = Net::HTTP.get(URI(url))
        recipes = JSON.parse(response)["meals"]
        recipes.each {|r| Recipe.new(name: r["strMeal"], recipe_id: r["idMeal"], ingredient: ingredient)}
    end

    def self.get_recipe_details(recipe)
        url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{recipe.recipe_id}"
        response = Net::HTTP.get(URI(url))
        info = JSON.parse(response)["meals"]
        recipe.recipe_details = info[0]["strInstructions"]
    end 
end 