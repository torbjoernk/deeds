module ApplicationHelper
  def model_name_with_icon(klass, quantity = :singular)
    raise StandardError.new 'Only for ActiveRecord models.' unless klass <= ActiveRecord::Base

    if quantity == :singular
      name = klass.model_name.human(count: 1)
    elsif quantity == :plural
      name = klass.model_name.human(count: 2)
    else
      raise StandardError.new "Quantity must be either :singular or :plural, not #{quantity}."
    end

    "#{icon_for(klass)} #{name}".strip.html_safe
  end

  def link_to_show_entity(entity, url=nil, remote=true)
    url ||= url_for(entity)
    link_to url,
            class: 'btn btn-sm btn-outline-info',
            id: "btn-#{entity.class.model_name.to_s.downcase}-show-#{entity.id}",
            title: t('views.actions.show_details'),
            data: { toggle: 'tooltip', placement: 'left' },
            remote: remote do
      content_tag(:i, nil, class: 'fa fa-fw fa-search')
    end
  end

  def link_to_edit_entity(entity)
    link_to url_for([:edit, entity]),
            controller: entity.class.model_name.plural,
            class: 'btn btn-sm btn-outline-primary',
            id: "btn-#{entity.class.model_name.to_s.downcase}-edit-#{entity.id}",
            title: t('views.actions.edit_entity',
                     entity_name: entity.class.model_name.human(count: 1)),
            data: { toggle: 'tooltip', placement: 'left' },
            remote: true do
      content_tag(:i, nil, class: 'fa fa-fw fa-pencil')
    end
  end

  def link_to_destroy_entity(entity, options={})
    defaults = {
        method: :delete,
        class: 'btn btn-sm btn-outline-danger',
        id: "btn-#{entity.class.model_name.to_s.downcase}-delete-#{entity.id}",
        title: t('views.actions.delete_entity',
                 entity_name: entity.class.model_name.human(count: 1)),
        data: {
            confirm: t('helpers.confirmation.delete'),
            toggle: 'tooltip',
            placement: 'left'
        }
    }
    defaults.merge!(options)
    link_to url_for(entity), **defaults do
      content_tag(:i, nil, class: 'fa fa-fw fa-trash')
    end
  end
end
