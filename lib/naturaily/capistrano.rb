#encoding: utf-8
require 'colored'

Capistrano::Configuration.instance.load do

  on :after, 'common:load_recipes', only: self.stages

  namespace :common do
    desc 'Load custom recipes'
    task :load_recipes do
      require_recipes
    end
  end

  def require_recipes
    loaded = self.recipes.map do |recipe|
      recipe, *environments = recipe if recipe.is_a?(Array)

      next if environments and not environments.include?(self.rails_env.to_sym)

      filename = File.expand_path("recipes/#{recipe}.rb", File.dirname(__FILE__))

      if File.exists?(filename)
        require filename

        recipe
      else
        raise StandardError,"Recipe '#{recipe} has not been found."
      end
    end

    puts "---> Loading recipes: #{loaded.compact.join(', ')}"
  end

end
