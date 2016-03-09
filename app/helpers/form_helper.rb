module FormHelper
  def form_modal_title(klass)
    "#{action_name.humanize} #{model_name_with_icon klass, :singular}".html_safe
  end
end
