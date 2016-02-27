#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  $('#archive-modal').html(
    "<%= escape_javascript(render(partial: 'archives/show')) %>"
  ).modal('show')
