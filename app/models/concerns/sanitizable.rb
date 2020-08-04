# frozen_string_literal: true

module Sanitizable
  extend ActiveSupport::Concern

  delegate :sanitize_sql_value, to: "self.class"
  delegate :quote_column_name, to: "self.class.connection"

  class_methods do
    def sanitize_sql_value(value)
      sanitize_sql_array ["?", value]
    end
  end
end
