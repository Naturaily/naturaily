module Naturaily
  module ActiveRecord
    module Querying
      delegate :with, to: :scoped
    end
  end
end
