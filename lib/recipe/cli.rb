class Cli 

    def run
        puts " "
        puts "Welcome to Ronnie's Recipe Finder"
        puts " "
        puts "Search for an ingredient or dish name, or type 'random' to see a random recipe:"
        puts " "
        @ingredient = gets.strip.downcase
        Api.get_recipes(@ingredient)
        print_recipes(Recipe.all) #will use find_by later
        prompt
        input = gets.strip.downcase
        #re-write as case statement
        while input != 'exit'
            if input == 'list'
                print_recipes(Recipe.find_by_ingredient(@ingredient))
            elsif input.to_i > 0 && input.to_i <= Recipe.find_by_ingredient(@ingredient).count
                recipe = Recipe.find_by_ingredient(@ingredient)[input.to_i - 1]
                Api.get_recipe_info(recipe) if !recipe.instructions
                print_recipe(recipe)
            elsif input == 'ingredient'
                #do later -- to start over
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
        puts " "
        puts "Recipe(s) matching your search term:"
        puts " "
        recipes.each.with_index(1) do |recipe, index|
            puts "#{index}. #{recipe.name}"
        end 
    end
    
    def print_recipe(recipe)
        puts recipe.name
        puts recipe.instructions
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
end 