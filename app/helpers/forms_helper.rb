module FormsHelper

  def cancel_button(url, text="Cancel")
    link_to url, title: text, class: 'btn btn-default' do
      fa_icon 'times', text: text
    end
  end

  def submit_button(text="Save", opts = {})
    size = opts.delete(:size) || 'md'
    icon = opts.delete(:icon) || 'check'
    content_tag :button, opts.merge(type: :submit, class: "btn btn-#{size} btn-primary", data: { disable_with: disable_with_text(opts.delete(:feedback_text)) }) do
      fa_icon icon, text: text
    end
  end

  def search_button(text = "Search")
    content_tag :button, type: :submit, class: 'btn btn-default', data: { disable_with: disable_with_text('Search') } do
      fa_icon 'search', text: text
    end
  end

  def reset_link(url)
    link_to url, class: 'btn btn-link' do
      fa_icon 'undo', text: 'Reset'
    end
  end

  def dismiss_modal_button(text = "Close")
    link_to fa_icon('times', text: text), '#', class: 'btn btn-default', data: { dismiss: 'modal' }
  end

  private
    def disable_with_text(feedback_text)
      feedback_text = 'Saving...' if feedback_text.blank?
      "<i class='fa fa-fw fa-spin fa-spinner'></i> #{feedback_text}".html_safe
    end

end