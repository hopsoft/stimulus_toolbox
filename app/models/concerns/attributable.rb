# frozen_string_literal: true

module Attributable
  extend ActiveSupport::Concern

  def attr_invalid?(attr_name)
    errors[attr_name.to_sym].present?
  end

  def attr_valid?(attr_name)
    !attr_invalid? attr_name
  end
end
