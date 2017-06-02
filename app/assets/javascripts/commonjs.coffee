$(document).on 'ready page:load', ->

  $.rails.allowAction = (link) ->
    if !link.attr('data-confirm')
      return true
    $.rails.showConfirmDialog link
    false

  $.rails.confirmed = (link) ->
    link.removeAttr 'data-confirm'
    link.trigger 'click.rails'

  $.rails.showConfirmDialog = (link) ->
    message = link.attr('data-confirm')
    $('#modal_text').text message
    box = $('#confirmation_modal')
    box.openModal()
    $('#confirmation_modal #button-confirm').on 'click', ->
      $.rails.confirmed link
  $('#items-list').on 'submit', (e) ->
    # validation code here
    if $('#btd_delete').hasClass('disabled')
      e.preventDefault()
      return

  if $('#notice').val() != '' and $('#notice').val() != undefined
    type = $('#notice').attr('data-type')
    state = $('#notice').attr('data-state')
    rollback = $('#notice').attr('data-rollback')
    text = $('#notice').val()
    switch type
      when 'created'
        Materialize.toast '<i class="material-icons">info</i>&nbsp;<span>' + text + '</span>', 5000, 'rounded'
      when 'updated'
        Materialize.toast '<i class="material-icons">info</i>&nbsp;<span>' + text + '</span>', 5000, 'rounded'
      when 'error'
        if state == 'ok'
          Materialize.toast '<i class="material-icons">info</i>&nbsp;<span>' + text + '</span><a class="btn-flat yellow-text" href="' + rollback + '">Восстановить<a>', 10000, 'rounded'
        else
          Materialize.toast '<i class="material-icons">info</i>&nbsp;<span>' + text + '</span>', 5000, 'rounded'
      when 'deleted'
        if state == 'ok'
          Materialize.toast '<i class="material-icons">info</i>&nbsp;<span>' + text + '</span><a class="btn-flat yellow-text" href="' + rollback + '">Отмена<a>', 10000, 'rounded'
        else
          Materialize.toast '<i class="material-icons">info</i>&nbsp;<span>' + text + '</span>', 5000, 'rounded'
      else
        Materialize.toast '<i class="material-icons">info</i>&nbsp;<span>' + text + '</span>', 5000, 'rounded'
  $.expr[':'].contains = $.expr.createPseudo((arg) ->
    (elem) ->
      $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0
  )
  $('select').material_select();
  return
