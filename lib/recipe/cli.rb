class Cli
    def run
        puts " "
        puts "Welcome to Ronnie's Recipe Finder".colorize(:yellow)
        prompt_ingredient
        prompt
        input = gets.gsub(/[^a-zA-z]/xi, "")
        input_options(input)
        puts " "
        puts "---------------------------------------------"
        puts " "
        puts "Goodbye and happy cooking!".colorize(:yellow)
    end

    def print_recipes(recipes)
        puts " "
        puts "Recipe(s) matching your search term:".colorize(:green)
        puts " "
        recipes.each.with_index(1) do |recipe, index|
            puts "#{index}. #{recipe.name}"
        end 
        puts " "
        puts "Enter a number to see more information.".colorize(:red)
        input = gets.gsub(/[^\d]/, "")
        numbers(input)
    end
    
    def print_recipe(recipe)
        puts "Recipe for '#{recipe.name}'   #{recipe.cuisine}".colorize(:green)
        puts " "
        puts "Ingredients:".colorize(:color => :black, :background => :white)
          recipe.ingredients.each_with_index do |ingredient, index|
              puts "#{recipe.measures[index]} #{ingredient}"
          end
        puts " "
        puts "Instructions:".colorize(:color => :black, :background => :white)
        puts "#{recipe.instructions}"
        puts " "
    end 

    def print_random
        recipe = Api.get_random
        print_recipe(recipe)
    end 

    def input_options(input)
        while input != 'exit'
            case
            when input == 'list'
            print_recipes(Ingredient.find_by_ingredient(@ingredient).recipes)
            when input == 'ingredient'
                prompt_ingredient
            when input == 'random'
                print_random
            else
                puts "Command does not exist. Please try again.".colorize(:red)
                puts " "
            end 
            prompt 
            input = gets.gsub(/[^a-zA-z]/xi, "")
        end
    end 

    def numbers(input)
        if input.to_i > 0 && input.to_i <= Ingredient.find_by_ingredient(@ingredient).recipes.count
          recipe = Ingredient.find_by_ingredient(@ingredient).recipes[input.to_i - 1]
          Api.get_recipe_info(recipe) if !recipe.instructions
          print_recipe(recipe)
        else 
            puts " "
            "Sorry, that's an invalid number."
        end
    end 

    def prompt
        puts " "
        puts " "
        puts "Options:".colorize(:red) 
        puts "Type 'list' to see the list again.".colorize(:yellow)
        puts "Type 'ingredient' to select a new ingredient.".colorize(:green)
        puts "Type 'random' to see a random recipe.".colorize(:blue)
        puts "Or type 'exit' to leave.".colorize(:magenta)
        puts " "
    end 

    def prompt_ingredient
        puts " "
        puts "Search for an ingredient or dish name, or type 'random' to see a random recipe:".colorize(:yellow)
        puts " "
        @ingredient = gets.gsub(/[^a-zA-z]/xi, "").downcase

        if @ingredient == 'random'
            print_random
        else
          Api.get_recipes(@ingredient) if !Ingredient.find_by_ingredient(@ingredient)
          print_recipes(Ingredient.find_by_ingredient(@ingredient).recipes)
        end 
    end
end 

#if no recipes found -- do not prompt for number 
#shouldnt be able to enter a number in response to ingredient or random prompt
#going directly from random to list throws an error 
#if statement to prevent space and number from returning Big List
