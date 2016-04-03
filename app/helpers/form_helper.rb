module FormHelper
  def form_modal_title(klass)
    t(action_name,
      scope: [:views, klass.model_name.to_s.downcase.to_sym, :modals],
      what: model_name_with_icon(klass, :singular)).html_safe
  end
end
