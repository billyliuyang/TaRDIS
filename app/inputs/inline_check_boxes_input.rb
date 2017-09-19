class InlineCheckBoxesInput < SimpleForm::Inputs::CollectionCheckBoxesInput

  def input(wrapper_options = nil)
    label_method, value_method = detect_collection_methods

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    @builder.send("collection_check_boxes",
      attribute_name, collection, value_method, label_method,
      input_options, merged_input_options,
      &collection_block_for_nested_boolean_style
    )
  end


  def apply_default_collection_options!(options)
    options[:item_wrapper_tag] = nil
    options[:item_label_class] = 'checkbox-inline'
    options[:collection_wrapper_tag] ||= options.fetch(:collection_wrapper_tag, SimpleForm.collection_wrapper_tag)
    options[:collection_wrapper_class] = [
      options[:collection_wrapper_class], SimpleForm.collection_wrapper_class
    ].compact.presence
  end

end