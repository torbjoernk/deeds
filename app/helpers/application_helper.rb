module ApplicationHelper
  def icon_for(klass)
    begin
      "<i class=\"fa fa-fw fa-#{klass::ICON}\"></i>".html_safe
    rescue
      logger.warn "No icon defined for model #{klass}."
      ''
    end
  end

  def model_name_with_icon(klass, quantity = :singular)
    raise StandardError.new 'Only for ActiveRecord models.' unless klass <= ActiveRecord::Base

    if quantity == :singular
      name = klass.model_name.human
    elsif quantity == :plural
      name = klass.model_name.plural.humanize
    else
      raise StandardError.new "Quantity must be either :singular or :plural, not #{quantity}."
    end

    "#{icon_for(klass)} #{name}".strip.html_safe
  end

  def link_to_show_entity(entity)
    link_to url_for(entity),
            class: 'btn btn-sm btn-outline-info',
            id: "btn-#{entity.class.model_name.to_s.downcase}-show-#{entity.id}",
            title: 'Show Details',
            data: { toggle: 'tooltip' },
            remote: true do
      (content_tag(:i, nil, class: 'fa fa-fw fa-search') + 'Show').html_safe
    end
  end

  def link_to_edit_entity(entity)
    link_to url_for([:edit, entity]),
            controller: entity.class.model_name.plural,
            class: 'btn btn-sm btn-outline-primary',
            id: "btn-#{entity.class.model_name.to_s.downcase}-edit-#{entity.id}",
            title: "Edit #{entity.class.model_name.human}",
            data: { toggle: 'tooltip' },
            remote: true do
      (content_tag(:i, nil, class: 'fa fa-fw fa-pencil') + 'Edit').html_safe
    end
  end

  def link_to_destroy_entity(entity)
    link_to url_for(entity),
            method: :delete,
            class: 'btn btn-sm btn-outline-danger',
            id: "btn-#{entity.class.model_name.to_s.downcase}-delete-#{entity.id}",
            title: "Delete #{entity.class.model_name.human}",
            data: {
              confirm: 'Do you really want to delete this item?',
              toggle: 'tooltip'
            } do
      (content_tag(:i, nil, class: 'fa fa-fw fa-trash') + 'Delete').html_safe
    end
  end
end
