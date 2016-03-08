#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  $('#deed-modal').html(
    "<%= escape_javascript(render(partial: 'deeds/show')) %>"
  ).modal('show')
