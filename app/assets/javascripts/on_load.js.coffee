#= depend_on jquery2
#= depend_on tether/tether
#= depend_on bootstrap/bootstrap

$(document).on 'ready page:change', ->
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="collapse"]').collapse()
