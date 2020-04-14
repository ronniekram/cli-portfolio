class Cli 

    def run
        puts " " 
        puts "Welcome to Ronnie's Recipe Finder!"
        puts " "
        puts "Search for recipe by ingredient or dish name:"
        puts " "
        @input = gets.strip.downcase
        Api.get_recipe(@input)
        print_recipes()
        prompts
        input = gets.strip.downcase
        while input != 'exit'
            #change to case statements
            if input == 'list'
                print_recipes(Recipe.find_by_ingredient(@ingredient))
            elsif input.to_i > 0 && input.to_i <=  Recipe.find_by_ingredient(@ingredient).length
                recipe = Recipe.find_by_ingredient(@ingredient[input.to_i - 1])
                Api.get_recipe_details(recipe) if !recipe.recipe_details
                print_recipe(recipe)
            elsif input == "ingredient"
                #what to do
            else 
                puts " "
                puts "We can't find what you're looking for. Please try again."
            end 
            prompt 
            input = gets.strip.downcase
        end
        puts " "
        puts "Goodbye and happy cooking!"
    end
    
    def print_recipe(recipes)
        puts " "
        puts "These are recipes matching your search terms:"
        puts " "
        recipes.each.with_index(1) do |recipe, index|
            puts "#{index}. #{recipe.name}"
        end 
    end
    
    def prompts
        puts " "
        puts "Select a number to see the recipe, type list to see the recipe list again, or type 'exit' to leave."
        puts " "
    end
    
    def print_recipe(recipe)
        puts recipe.name 
        puts " "
        puts recipe.recipe_details
    end 
end 