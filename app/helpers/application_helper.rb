# frozen_string_literal: true

module ApplicationHelper
  def class_names(*args)
    values = []

    args.each do |arg|
      case arg
      when Hash
        arg.each { |key, val| values << key if val }
      when Array
        arg.each { |a| values << class_names(a) }
      else
        values << arg if arg.present?
      end
    end

    values.compact.flatten
  end

  def prev_page
    @pagy.prev || 1
  end

  def next_page
    @pagy.next || @pagy.last
  end

  def human_count(value)
    return "-" if value.to_i == 0
    number_with_delimiter value
  end
end
