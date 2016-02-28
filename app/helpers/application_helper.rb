module ApplicationHelper
  def link_to_show_entity(entity)
    link_to url_for(entity),
            class: 'btn btn-sm btn-outline-info',
            id: "btn-#{entity.class.model_name.to_s.downcase}-show-#{entity.id}",
            title: 'Show Details',
            data: { toggle: 'tooltip' },
            remote: true do
      content_tag(:i, nil, class: 'fa fa-fw fa-search')
    end
  end

  def link_to_edit_entity(entity)
    link_to url_for([:edit, entity]),
            controller: entity.class.model_name.plural,
            class: 'btn btn-sm btn-outline-info',
            id: "btn-#{entity.class.model_name.to_s.downcase}-edit-#{entity.id}",
            title: "Edit #{entity.class.model_name.human}",
            data: { toggle: 'tooltip' },
            remote: true do
      content_tag(:i, nil, class: 'fa fa-fw fa-pencil')
    end
  end

  def link_to_destroy_entity(entity)
    link_to url_for(entity),
            method: :delete,
            class: 'btn btn-sm btn-outline-info',
            id: "btn-#{entity.class.model_name.to_s.downcase}-delete-#{entity.id}",
            title: "Delete #{entity.class.model_name.human}",
            data: {
              confirm: 'Do you really want to delete this item?',
              toggle: 'tooltip'
            } do
      content_tag(:i, nil, class: 'fa fa-fw fa-trash')
    end
  end
end
