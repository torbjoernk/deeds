#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  $('#content-modal').html(
    "<%= escape_javascript(render(partial: 'contents/show')) %>"
  ).modal('show')
