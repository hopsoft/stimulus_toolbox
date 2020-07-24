class ApplicationRecord < ActiveRecord::Base
  include Bg::Deferrable::Behavior
  include Sanitizable

  self.abstract_class = true
end
