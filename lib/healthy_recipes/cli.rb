  
    class HealthyRecipes::CLI
    
    def start
         input =  nil
          until input == "exit"
            greetings
            get_courses
            list_courses
            get_user_course
            puts "Type exit to exit or type any key to to view all courses again.".colorize(:magenta)
            input = gets.strip.downcase
            system("clear")
        end
         farewell
    end
    
    def greetings
         colorizer = Lolize::Colorizer.new
         lolize
         colorizer.write "                              Welcome!!                                              \n"
         puts " "
         colorizer.write "\                      All recipes are from Skinnytaste                                \n"
         lolize
         puts ""
        end 
    
    def get_courses
         courses = HealthyRecipes::Course.all
         end
    
    def list_courses
          puts "Type the number of the course to see its recipes".colorize(:magenta)
          puts ""
           get_courses.each.with_index(1) do |course, index|
            puts "#{index}. #{course.name}"    
         end
         end
    
    # check if valid course
    # break loop once condition is true
    def get_user_course
          chosen_course = gets.strip.to_i
        while chosen_course != nil
            if valid_input(chosen_course.to_i, get_courses)
                 show_recipes_for(chosen_course)
                   break
                 else 
                      puts "oops wrong number try again".colorize(:red)
                      puts ""  
                      chosen_course = gets.strip.to_i
                    end
                end
            end
    
    def valid_input(input, data)
      input.to_i <= data.length && input.to_i > 0
    end
    
    def show_recipes_for(chosen_course)
         course = get_courses[chosen_course - 1]
          course.get_recipes
          puts ""
          lolize
          puts ""
           puts "Recipes for #{course.name} loading...".colorize(:magenta)
           course.recipes.each.with_index(1) do |recipe, index|
              sleep(1)
               puts "#{index}. #{recipe.name}"
             end  
             puts "Type the number of the recipe to see more details".colorize(:magenta)
             get_user_recipe(course)
            end
    
    # shows recipe details
    # validate input
    # break loop once condition is true
    def get_user_recipe(course)
         chosen_recipe = gets.strip.to_i
          while chosen_recipe != nil
            recipe = course.recipes[chosen_recipe.to_i - 1]
            if valid_input(chosen_recipe.to_i, course.recipes)
                recipe.get_ingredients
                recipe.get_instructions
                show_ingredients(recipe)
                show_instructions(recipe)
                 break
                else
                    puts ""
                    puts "oops wrong number, try again".colorize(:red)
                    chosen_recipe = gets.strip.to_i 
                end
            end
        end
    
    def show_ingredients(recipe)
        puts ""
        lolize
        puts ""
         puts  recipe.name.colorize(:magenta)
        puts ""
        puts "Ingredients"
        puts ""
         recipe.ingredients.each {|i| puts "- #{i}"}
    end
    
    def show_instructions(recipe)
         puts ""
         puts "Instructions"
         puts ""
         recipe.instructions.each.with_index(1) {|i, num| puts "#{num}. #{i}"}
         puts ""
    end
     
    def farewell
        puts ""
        puts "Thank you for stopping by!!!".colorize(:magenta)
        puts ""
    end
    
    def lolize
        colorizer = Lolize::Colorizer.new
        colorizer.write "\n-------------------------------------------------------------------------------\n"
    end
end