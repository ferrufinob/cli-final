class HealthyRecipes::Course
    attr_accessor :name, :recipes, :ref
  
    @@all = []
    
    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
        @recipes = []
        save
    end

        # if empty scrape_courses
    def self.all
         HealthyRecipes::Scraper.scrape_courses if @@all.empty?
         @@all
    end
    
     # return a recipes array
    #  self = recipes course
    def get_recipes
        HealthyRecipes::Scraper.scrape_recipes(self) if @recipes.empty?
    end

    def save
        @@all << self
    end 

end
