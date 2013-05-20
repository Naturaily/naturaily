require 'naturaily/active_record'

module Naturaily
  class Railtie < Rails::Railtie

    config.before_initialize do
      ::ActiveRecord::Relation.send :include, Naturaily::ActiveRecord::QueryMethods
      ::ActiveRecord::Base.send :extend, Naturaily::ActiveRecord::Querying
    end
  end
end
