require 'colored'

def extensions(*names)
  names.each do |name|
    filename= File.expand_path("extensions/#{name}", File.dirname(__FILE__))

    if File.exists?(filename)
        require filename
    else
        raise StandardError,"Extension '#{name} has not been found."
    end
  end
end
