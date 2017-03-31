class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  def simple_label(method, options = {})
    options = options.reverse_merge(class: 'control-label')

    label_col(label(method, method.to_s.humanize.titlecase, options))
  end

  def simple_collection_select(method, collection, value, text, options = {}, html_options = {})
    html_options = html_options.reverse_merge(class: 'form-control')
    options = options.reverse_merge(prompt: 'None')

    form_group(method) do
      concat simple_label(method)
      concat input_col(collection_select(method, collection, value, text, options, html_options))
    end
  end

  def simple_select(method, collection, options = {}, html_options = {})
    html_options = html_options.reverse_merge(class: 'form-control')
    options = options.reverse_merge(prompt: 'None')

    form_group(method) do
      concat simple_label(method)
      concat input_col(select(method, collection, options, html_options))
    end
  end

  def simple_date_field(method, html_options = {})
    html_options = html_options.reverse_merge(class: 'form-control')

    form_group(method) do
      concat simple_label(method)
      concat input_col(date_field(method, html_options))
    end
  end

  def simple_text_field(method, html_options = {})
    html_options = html_options.reverse_merge(class: 'form-control')

    form_group(method) do
      concat simple_label(method)
      concat input_col(text_field(method, html_options))
    end
  end

  def simple_number_field(method, html_options = {})
    html_options = html_options.reverse_merge(class: 'form-control')

    form_group(method) do
      concat simple_label(method)
      concat input_col(number_field(method, html_options))
    end
  end

  def simple_currency_field(method, options = {})
    form_group(method) do
      concat simple_label(method)
      concat hidden_field("#{method}_currency", value: Transaction::CURRENCY.first)
      concat(input_col(input_group do
        concat text_field("#{method}_cents", class: 'form-control')
        concat content_tag(:span, Transaction::CURRENCY.first.upcase, class: 'input-group-addon')
      end))
    end
  end

  def submit(value = nil, options = {})
    options = options.reverse_merge(class: 'btn btn-primary')
    content_tag(:div, class: 'form-group') do
      content_tag(:div, class: 'form-actions col-sm-offset-3 col-sm-9') do
        super
      end
    end
  end

  def label_col(content = nil, &block)
    content_tag(:div, content, class: 'col-sm-3', &block)
  end

  def input_col(content = nil, &block)
    content_tag(:div, content, class: 'col-sm-9', &block)
  end

  def input_group(content = nil, &block)
    content_tag(:div, content, class: 'input-group', &block)
  end

  def form_group(*methods)
    content_tag(:div, class: "form-group #{'has-error' if any_errors?(*methods)}") do
      yield

      methods.each do |method|
        errors_tag(method)
      end
    end
  end

  def any_errors?(*methods)
    methods.any? do |method|
      key = method.to_s.chomp('_id').to_sym
      object.errors[key].any?
    end
  end

  def errors_tag(method)
    key = method.to_s.chomp('_id').to_sym

    object.errors.full_messages_for(key).each do |message|
      concat content_tag(:div, message, class: 'help-block col-sm-offset-3 col-sm-9')
    end
  end

  def batch_form_group(*methods)
    content_tag(:div, class: "#{'has-error' if any_errors?(*methods)}") do
      yield
    end
  end

  def batch_text_field(method, html_options = {})
    html_options = html_options.reverse_merge(class: 'form-control')

    batch_form_group(method) do
      text_field(method, html_options)
    end
  end

  def batch_collection_select(method, collection, value, text, options = {}, html_options = {})
    html_options = html_options.reverse_merge(class: 'form-control')
    options = options.reverse_merge(prompt: '-', default: '')

    batch_form_group(method) do
      collection_select(method, collection, value, text, options, html_options)
    end
  end

  def batch_date_field(method, html_options = {})
    html_options = html_options.reverse_merge(class: 'form-control')

    batch_form_group(method) do
      date_field(method, html_options)
    end
  end

  def batch_number_field(method, html_options = {})
    html_options = html_options.reverse_merge(class: 'form-control')

    batch_form_group(method) do
      number_field(method, html_options)
    end
  end

  def batch_currency_field(method, options = {})
    batch_form_group(method) do
      concat hidden_field("#{method}_currency", value: Transaction::CURRENCY.first)
      concat(input_group do
        concat text_field("#{method}_cents", class: 'form-control')
        concat content_tag(:span, Transaction::CURRENCY.first.upcase, class: 'input-group-addon')
      end)
    end
  end

  def template
    @template
  end

  delegate :content_tag, to: 'template'
  delegate :concat, to: 'template'
  delegate :capture, to: 'template'
end
