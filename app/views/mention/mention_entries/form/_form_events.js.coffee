$ ->
  form_modal = $('#form-modal')

  assoc_deed_container = form_modal.find('#assoc-deed')
  assoc_deed_input = assoc_deed_container.find('#mention_mention_entry_deed')

  valid_deeds = <%= raw Deed.all.map { |x| x.title }.to_json %>
  deeds_id_map = <%= raw Deed.all.map { |x| { x.title => x.id } }.reduce({}, :update).to_json %>

  assoc_deed_input.on 'input', ->
    $(this).removeClass('form-control-success').removeClass('.form-control-danger')
    $(this).parent().removeClass('has-success').removeClass('has-danger')
    if $(this).prop('value') in valid_deeds
      $(this).addClass('form-control-success')
      $(this).parent().addClass('has-success')
    else
      $(this).addClass('form-control-danger')
      $(this).parent().addClass('has-danger')

  assoc_deed_container.find('#btn-show-selected-deed-details').click ->
    value = assoc_deed_input.prop('value')
    if value in valid_deeds
      $.get
        url: '/deeds/' + deeds_id_map[value]
        dataType: 'script'
    else
      alert <%= t('views.deed.none_selected') %>


  assoc_person_container = form_modal.find('#assoc-person')
  assoc_person_input = assoc_person_container.find('#mention_mention_entry_person')

  valid_people = <%= raw Person.all.map { |x| x.name }.to_json %>
  people_id_map = <%= raw Person.all.map { |x| { x.name => x.id } }.reduce({}, :update).to_json %>

  assoc_person_input.on 'input', ->
    $(this).removeClass('form-control-success').removeClass('.form-control-danger')
    $(this).parent().removeClass('has-success').removeClass('has-danger')
    if $(this).prop('value') in valid_people
      $(this).addClass('form-control-success')
      $(this).parent().addClass('has-success')
    else
      $(this).addClass('form-control-danger')
      $(this).parent().addClass('has-danger')

  assoc_person_container.find('#btn-show-selected-person-details').click ->
    value = assoc_person_input.prop('value')
    if value in valid_people
      $.get
        url: '/people/' + people_id_map[value]
        dataType: 'script'
    else
      alert '<%= t('views.person.none_selected') %>'


  assoc_place_container = form_modal.find('#assoc-place')
  assoc_place_input = assoc_place_container.find('#mention_mention_entry_place')

  valid_places = <%= raw Place.all.map { |x| x.title }.to_json %>
  places_id_map = <%= raw Place.all.map { |x| { x.title => x.id } }.reduce({}, :update).to_json %>

  assoc_place_input.on 'input', ->
    $(this).removeClass('form-control-success').removeClass('.form-control-danger')
    $(this).parent().removeClass('has-success').removeClass('has-danger')
    if $(this).prop('value') in valid_places
      $(this).addClass('form-control-success')
      $(this).parent().addClass('has-success')
    else
      $(this).addClass('form-control-danger')
      $(this).parent().addClass('has-danger')

  assoc_place_container.find('#btn-show-selected-place-details').click ->
    value = assoc_place_input.prop('value')
    if value in valid_places
      $.get
        url: '/places/' + places_id_map[value]
        dataType: 'script'
    else
      alert '<%= t('views.place.none_selected') %>'


  assoc_role_container = form_modal.find('#assoc-role')
  assoc_role_input = assoc_role_container.find('#mention_mention_entry_role')

  valid_roles = <%= raw Role.all.map { |x| x.title }.to_json %>
  roles_id_map = <%= raw Role.all.map { |x| { x.title => x.id } }.reduce({}, :update).to_json %>

  assoc_role_input.on 'input', ->
    $(this).removeClass('form-control-success').removeClass('.form-control-danger')
    $(this).parent().removeClass('has-success').removeClass('has-danger')
    if $(this).prop('value') in valid_roles
      $(this).addClass('form-control-success')
      $(this).parent().addClass('has-success')
    else
      $(this).addClass('form-control-danger')
      $(this).parent().addClass('has-danger')

  assoc_role_container.find('#btn-show-selected-role-details').click ->
    value = assoc_role_input.prop('value')
    if value in valid_roles
      $.get
        url: '/roles/' + roles_id_map[value]
        dataType: 'script'
    else
      alert '<%= t('views.role.none_selected') %>'
