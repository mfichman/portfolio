class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.upsert!(values, conflict=[])
    return if values.blank?

    values = Array.wrap(values)

    attribute_names = self.attribute_names - %w(id)
    attribute_names_format = "(#{(['?'] * attribute_names.count).join(',')})"

    values = values.map do |entry|
      model = new(entry)
      model.validate!
      attributes = model.slice(*attribute_names)
      attributes.merge!(created_at: 'now()', updated_at: 'now()')
      sanitize_sql_array([attribute_names_format, *attributes.values])
    end

    attribute_names = attribute_names.join(',')
    values = values.join(',')
    conflict = conflict.join(',')

    query = "INSERT INTO #{table_name} (#{attribute_names}) VALUES #{values}" # ON CONFLICT (#{conflict}) DO UPDATE"
    query = sanitize_sql_array([query])

    connection.execute(query)
  end

  def humanize
    to_param
  end
end
