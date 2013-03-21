require 'colored'

def load_recipes(*names)
  names.each do |name|
    filename= File.expand_path("recipes/#{name}.rb", File.dirname(__FILE__))

    if File.exists?(filename)
        require filename
    else
        raise StandardError,"Recipe '#{name} has not been found."
    end
  end
end
