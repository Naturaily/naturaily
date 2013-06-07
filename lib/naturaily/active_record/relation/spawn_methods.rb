module Naturaily
  module ActiveRecord
    module SpawnMethods
      extend ActiveSupport::Concern

      def except(*skips)
        result = super
        result.send("with_values=", send(:with_values)) unless skips.include? :with
        result
      end

      def only(*onlies)
        result = super
        result.send("with_values=", send(:with_values)) if onlies.include? :with
        result
      end
    end
  end
end
