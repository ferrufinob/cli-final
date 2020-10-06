class VegetarianRecipes::Course
    attr_accessor :name, :recipes, :ref

    @@all = []
    
    def initialize(name,ref)
        @name = name
        @ref = ref
        @recipes = []
        save
    end

    def self.all
        VegetarianRecipes::Scraper.scrape_courses if @@all.empty?
        @@all
    end

    def get_recipes
        # return a recipes array
        VegetarianRecipes::Scraper.scrape_recipes(self) if @recipes.empty?
    end

    def save
        @@all << self
    end 

end
