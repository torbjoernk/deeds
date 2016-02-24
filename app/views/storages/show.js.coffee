#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  $('#storage-modal').html(
    "<%= escape_javascript(render(partial: 'storages/show')) %>"
  ).modal('show')
