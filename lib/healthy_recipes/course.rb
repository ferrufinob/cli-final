class HealthyRecipes::Course
    attr_accessor :name, :recipes, :ref

    @@all = []
    
    def initialize(name,ref)
        @name = name
        @ref = ref
        @recipes = []
        save
    end

    def self.all
         HealthyRecipes::Scraper.scrape_courses if @@all.empty?
         @@all
    end
    
     # return a recipes array
    def get_recipes
        HealthyRecipes::Scraper.scrape_recipes(self) if @recipes.empty?
    end

    def save
        @@all << self
    end 

end
