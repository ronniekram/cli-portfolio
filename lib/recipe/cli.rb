class Cli 
  #split run into smaller methods
    def run
        puts " "
        puts "Welcome to Ronnie's Recipe Finder"
        prompt_ingredient
        prompt
        input = gets.strip.downcase
        #re-write as case statement
        while input != 'exit'
            if input == 'list'
                print_recipes(Ingredient.find_by_ingredient(@ingredient).recipes) #returns an object
            elsif input.to_i > 0 && input.to_i <= Ingredient.find_by_ingredient(@ingredient).recipes.count
                recipe = Ingredient.find_by_ingredient(@ingredient).recipes[input.to_i - 1]
                Api.get_recipe_info(recipe) if !recipe.instructions
                print_recipe(recipe)
            elsif input == 'ingredient'
                prompt_ingredient
            else 
                puts "Nothing matches your input. Please try again."
                puts " "
            end
            prompt 
            input = gets.strip.downcase
        end
        puts " "
        puts "Goodbye and happy cooking!" 
    end
    
    def print_recipes(recipes)
        space
        puts "Recipe(s) matching your search term:"
        puts " "
        recipes.each.with_index(1) do |recipe, index|
            puts "#{index}. #{recipe.name}"
        end 
    end
    
    def print_recipe(recipe)
        space 
        puts "Recipe for #{recipe.name} -- Cuisine: #{recipe.cuisine}"
        puts " "
        puts "Ingredients:"
          recipe.ingredients.each_with_index do |ingredient, index|
              puts "#{recipe.measures[index]} #{ingredient}"
          end
        puts " "
        puts "Instructions:"
        puts "#{recipe.instructions}" 
    end 

    def prompt
        puts " "
        puts "Choose a recipe number to see more information." 
        puts "Type 'list' to see the list again."
        puts "Type 'ingredient' to select a new ingredient."
        puts "Type 'random' to see a random recipe."
        puts "Or type 'exit' to leave."
        puts " "
    end 

    def prompt_ingredient
        puts " "
        puts "Search for an ingredient or dish name, or type 'random' to see a random recipe:"
        puts " "
        @ingredient = gets.strip.downcase
        #if it returns nil, object will be created
        #if not nil, it will return existing object
        Api.get_recipes(@ingredient) if !Ingredient.find_by_ingredient(@ingredient)
        print_recipes(Ingredient.find_by_ingredient(@ingredient).recipes)
    end
    
    def space
        puts "-----------------------"
        puts " "
    end 
end 