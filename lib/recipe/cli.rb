class Cli
    def run
        puts " "
        puts "Welcome to Ronnie's Recipe Finder"
        prompt_ingredient
        prompt
        input = gets.gsub(/[^a-zA-z]/, "").downcase
        while input != 'exit'
            case
            when input == 'list'
                print_recipes(Ingredient.find_by_ingredient(@ingredient).recipes)
            when input == 'ingredient'
                prompt_ingredient
            when input == 'random'
                space
                print_random
            when input.to_i > 0 && input.to_i <= Ingredient.find_by_ingredient(@ingredient).recipes.count
                input.gsub(/[^\d]/, "")
                recipe = Ingredient.find_by_ingredient(@ingredient).recipes[input.to_i - 1]
                Api.get_recipe_info(recipe) if !recipe.instructions
                print_recipe(recipe)
            else
                puts "Command does not exist. Please try again."
                puts " "
            end 
            prompt 
            input = gets.strip.downcase
        end
        space
        puts "Goodbye and happy cooking!"
        puts " " 
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
        puts "Recipe for '#{recipe.name}'   #{recipe.cuisine}"
        puts " "
        puts "Ingredients:"
          recipe.ingredients.each_with_index do |ingredient, index|
              puts "#{recipe.measures[index]} #{ingredient}"
          end
        puts " "
        puts "Instructions:"
        puts "#{recipe.instructions}" 
    end 

    def print_random
        recipe = Api.get_random
        print_recipe(recipe)
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
        puts "Search for an ingredient, or type 'random' to see a random recipe:"
        puts " "
        @ingredient = gets.gsub(/[^a-zA-z]/, "").downcase

        if @ingredient == 'random'
            print_random
        else
          Api.get_recipes(@ingredient) if !Ingredient.find_by_ingredient(@ingredient)
          print_recipes(Ingredient.find_by_ingredient(@ingredient).recipes)
        end 
    end
    
    def space
        puts " "
        puts "-----------------------"
        puts " "
    end 

end 