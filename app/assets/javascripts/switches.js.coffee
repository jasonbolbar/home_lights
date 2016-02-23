$ ->
  $('.bootstrap-switch-input').on 'switchChange.bootstrapSwitch', (event, state) ->
    icon_id = $(this).attr('status_icon')
    $.post($(this).val(), status: state, ((data) ->
      document.getElementById(icon_id).src = data.icon
    ), 'json')
