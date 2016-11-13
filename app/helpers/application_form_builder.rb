class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, options = {})
    options = options.reverse_merge(class: 'col-sm-3 control-label')
    super(method, method.to_s.humanize.titlecase, options)
  end

  def simple_collection_select(method, *args)
    form_group(method) do 
      @template.concat label(method)
      collection_select(method, *args)
    end
  end

  def simple_select(method, *args)
    form_group(method) do 
      @template.concat label(method)
      select(method, *args)
    end
  end

  def simple_date_field(method, *args)
    form_group(method) do 
      @template.concat label(method)
      date_field(method, *args)
    end
  end

  def simple_text_field(method, *args)
    form_group(method) do 
      @template.concat label(method)
      text_field(method, *args)
    end
  end

  def simple_number_field(method, *args)
    form_group(method) do 
      @template.concat label(method)
      number_field(method, *args)
    end
  end

  def collection_select(method, collection, value, text, options = {}, html_options = {})
    html_options = html_options.reverse_merge(class: 'col-sm-9')
    options = options.reverse_merge(prompt: 'None')

    @template.content_tag(:div, html_options) do
      super(method, collection, value, text, options, class: 'form-control')
    end
  end

  def select(method, collection, options = {}, html_options = {})
    html_options = html_options.reverse_merge(class: 'col-sm-9')
    options = options.reverse_merge(prompt: 'None')

    @template.content_tag(:div, html_options) do
      super(method, collection, options, class: 'form-control')
    end
  end

  def text_field(method, options = {})
    html_options = { class: options[:class] || 'col-sm-9' }
    options = options.except(:class).reverse_merge(class: 'form-control')

    @template.content_tag(:div, html_options) do
      super(method, options)
    end
  end

  def number_field(method, options = {})
    html_options = { class: options[:class] || 'col-sm-9' }
    options = options.except(:class).reverse_merge(class: 'form-control')

    @template.content_tag(:div, html_options) do
      super(method, options)
    end
  end

  def date_field(method, options = {})
    html_options = { class: options[:class] || 'col-sm-9' }
    options = options.except(:class).reverse_merge(class: 'form-control')

    @template.content_tag(:div, html_options) do
      super(method, options)
    end
  end

  def simple_currency_field(method, options = {})
    form_group(method) do
      @template.capture do
        @template.concat label(method)
        @template.concat text_field("#{method}_cents", class: 'col-sm-7')
        @template.concat collection_select("#{method}_currency", Transaction::CURRENCIES, :itself, :upcase, {}, class: 'col-sm-2')
      end
    end
  end

  def submit(value = nil, options = {})
    options = options.reverse_merge(class: 'btn btn-primary')
    @template.content_tag(:div, class: 'form-group') do
      @template.content_tag(:div, class: 'form-actions col-sm-offset-3 col-sm-9') do
        super
      end
    end
  end

  def form_group(*methods)
    errors = methods.any? do |method|
      key = method.to_s.chomp('_id').to_sym
      object.errors[key].any?
    end

    @template.content_tag(:div, class: "form-group #{'has-error' if errors}") do
      @template.concat yield

      methods.each do |method|
        @template.concat errors(method)
      end
    end
  end

  def errors(method)
    key = method.to_s.chomp('_id').to_sym
    
    @template.capture do
      object.errors.full_messages_for(key).each do |message|
        @template.concat @template.content_tag(:div, message, class: 'help-block col-sm-offset-2 col-sm-9')
      end
    end
  end
end
