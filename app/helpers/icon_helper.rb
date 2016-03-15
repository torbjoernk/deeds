module IconHelper
  def icon_for(klass)
    begin
      "<i class=\"fa fa-fw fa-#{klass::ICON}\"></i>".html_safe
    rescue
      logger.warn "No icon defined for model #{klass}."
      ''
    end
  end

  def notes_icon
    '<i class="fa fa-comment-o fa-fw"></i>'.html_safe
  end
end
