module Naturaily
  module ActiveRecord
    module QueryMethods
      extend ActiveSupport::Concern

      attr_accessor :with_values

      def with(*args)
        return self if args.blank?

        relation = clone
        relation.with_values ||= []
        relation.with_values += build_with(args.first)
        relation
      end

      def build_arel
        arel = super
        collapse_withs(arel, @with_values) if @with_values
        arel
      end

      private

      def collapse_withs(arel, subqueries)
        values = subqueries.map do |name, query|
          query = query.is_a?(::ActiveRecord::Relation) ? query.to_sql : query.to_s
          Arel::SqlLiteral.new("#{name} AS (#{query})")
        end

        arel.with(values)
      end

      def build_with(args)
        case args
        when Hash
          args.to_a
        when Array
          args
        else
          []
        end
      end

    end
  end
end
