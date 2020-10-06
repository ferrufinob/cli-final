class HealthyRecipes::CLI

    require 'pry'
    class VegetarianRecipes::CLI
    
    def start
        @input =  nil
        until @input == "exit"
            greetings
            puts ""
            get_courses
            list_courses
            get_user_course
            next_step
        end
        farewell
    end
    
    def greetings
        colorizer = Lolize::Colorizer.new
        colorizer.write "\n-------------------------------------------------------------------------\n"
        
        colorizer.write "                            Welcome!!                                        \n "
        puts " "
       
        colorizer.write "\             Please choose from the categories below                        \n"
        puts " "
        
        colorizer.write "\-------------------------------------------------------------------------\n"
        puts ""
    end 
    
    def get_courses
        @courses = VegetarianRecipes::Course.all
    end
    
    def list_courses
        puts "choose a course to see recipe".colorize(:magenta)
        puts ""
        @courses.each.with_index(1) do |course, index|
            puts "#{index}. #{course.name}"    
        end
    end
    
    def get_user_course
        # check if valid course
        chosen_course = gets.strip.to_i
       if valid_input(chosen_course.to_i, @courses)
        show_recipes_for(chosen_course)
       else 
        puts ""
        puts "oops wrong number try again".colorize(:red)
        puts ""  
        get_user_course
    end
    end
    
    def valid_input(input, data)
      input.to_i <= data.length && input.to_i > 0
    end
    
    def show_recipes_for(chosen_course)
        course = @courses[chosen_course - 1]
        course.get_recipes
        
        puts ""
        puts ""
        colorizer = Lolize::Colorizer.new
        colorizer.write "\n-------------------------------------------------------------------------\n"
        puts ""
        puts "Here are recipes for #{course.name}".colorize(:magenta)
        puts ""
        course.recipes.each.with_index(1) do |recipe, index|
            puts "#{index}. #{recipe.name}"
        end  
        get_user_recipe(course)
    end
    
    # shows recipe details
    def get_user_recipe(course)
        chosen_recipe = gets.strip.to_i
        recipe = course.recipes[chosen_recipe.to_i - 1]
        if valid_input(chosen_recipe.to_i, course.recipes)
        recipe.get_ingredients
        recipe.get_instructions
        show_ingredients(recipe)
        show_instructions(recipe)
        else
            puts ""
            puts "oops wrong number, try again".colorize(:red)
            get_user_recipe(course)        
        end
    end
    
    def show_ingredients(recipe)
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
    
    def next_step
        puts ""
        puts "Type exit or type any key to return to all courses.".colorize(:magenta)
        @input = gets.strip
    end
    
    def farewell
        puts "Thank you for stopping by!!!".colorize(:magenta)
    end
    
    end