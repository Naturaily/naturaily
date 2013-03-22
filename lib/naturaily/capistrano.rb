require 'colored'

GEM_RECIPES = [
  [:sidekiq, 'sidekiq/capistrano'],
  [:whenever, 'whenever/capistrano']
]

Capistrano::Configuration.instance.load do

  on :after, only: stages do
    load_recipes
  end

  def load_recipes
    loaded = self.recipes.map do |recipe|
      recipe, *environments = recipe if recipe.is_a?(Array)

      next if environments and not environments.include?(self.rails_env)

      filename = File.expand_path("recipes/#{recipe}.rb", File.dirname(__FILE__))

      if path = gem_recipe(recipe) or File.exists?(filename)
        require path || filename

        recipe
      else
        raise StandardError,"Recipe '#{recipe} has not been found."
      end
    end

    logger.trace "Loaded recipes: #{loaded.compact.join(', ')}".red
  end

  def gem_recipe(name)
    result = GEM_RECIPES.find do |gem_name,_|
      gem_name == name
    end

    result ? result.last : nil
  end

end
