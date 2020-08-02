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
end
