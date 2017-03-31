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

  def menu_link(path, options = {}, &block)
    link_to(path, options, &block)
  end

  def menu_dropdown(name, path)
    classes = [
      ('open' if url_for.starts_with?(path)),
      ('menu-dropdown')
    ]

    content_tag(:li, class: classes.join(' '), data: { js_hook: 'menu-dropdown' }) do
      link = menu_link(path, data: { js_hook: 'menu-dropdown-link' }) do
        concat(name)
        concat(content_tag(:span, '', class: 'glyphicon glyphicon-chevron-down arrow-down'))
        concat(content_tag(:span, '', class: 'glyphicon glyphicon-chevron-right arrow-right'))
      end

      concat(link)

      yield
    end
  end

  def menu_item(name, path, &block)
    options = { class: ('active' if url_for.starts_with?(path)) }

    content_tag(:li) do
      menu_link(path, options) do
        concat(name)
      end
    end
  end

  def batch_submit_tag(action = nil, options = {})
    options = options.reverse_merge(class: 'btn btn-primary')

    case action
    when 'batch_update' then submit_tag('Update Batch', options)
    when 'batch_create' then submit_tag('Create Batch', options)
    end
  end
end
