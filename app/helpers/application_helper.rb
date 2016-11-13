module ApplicationHelper
  def form_for(method, options = {}) 
    options = options.reverse_merge(html: { class: 'form-horizontal' })
    super
  end

  def display_attribute_names_for(model)
    method = "#{model.model_name.singular}_attribute_names"

    if respond_to?(method)
      public_send(method)
    else
      model.attribute_names - ['id', 'created_at', 'updated_at']
    end
  end

  def format_attribute(record, name)
    method = "format_#{name}"
    value = record.public_send(name)

    if respond_to?(method) 
      public_send(method, value)
    else 
      value
    end
  end
end
