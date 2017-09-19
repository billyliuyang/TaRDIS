class DateStringInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    date = @builder.object.send attribute_name
    input_html = { value: (I18n.l date if date.is_a?(Date)) }
    merged_input_options = merge_wrapper_options(input_html_options.merge(input_html), wrapper_options)
    "#{@builder.text_field attribute_name, merged_input_options}".html_safe
  end
  
  def input_html_classes
    super.push('form-control')
  end
end