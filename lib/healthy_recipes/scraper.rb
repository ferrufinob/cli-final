
class HealthyRecipes::Scraper
    def self.scrape_courses
        doc = Nokogiri::HTML(open("https://www.skinnytaste.com/recipes/"))
        scraping_block = doc.css(".categories ul li")
        scraping_block.each do |course|
            name = course.text
            ref = course.css("a").attr("href").value
            HealthyRecipes::Course.new(name, ref) 
        end
    end


        def self.scrape_recipes(course)
           doc = Nokogiri::HTML(open("#{course.ref}"))
           recipes = doc.css(".archives .archive-post") 
             recipes.each do |recipe|
               name = recipe.css("a h4").text
               url = recipe.css("a").attr("href").value
             HealthyRecipes::Recipe.new(name, course, url)

           end   
        end

        
        def self.scrape_ingredients(recipe)
            doc = Nokogiri::HTML(open("#{recipe.url}")) 
            ingredients = doc.css("ul.wprm-recipe-ingredients li.wprm-recipe-ingredient")
            ingredients.each do |o|
              inf = o.text.strip  
              recipe.ingredients << inf
          end 
        end 

      
        def self.scrape_instructions(recipe)
          doc = Nokogiri::HTML(open("#{recipe.url}"))
          inst = doc.css(".wprm-recipe-instruction-group ul.wprm-recipe-instructions li")
          inst.each do |o|
            instruct = o.text.strip
            recipe.instructions << instruct
          end
        end
      end

        
    

