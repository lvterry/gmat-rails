$ ->
  $('.delete-exercise').on 'click', (e) ->
    e.preventDefault()
    if window.confirm('确认删除吗？')
      $(@).parents('tr').remove()
      $.ajax
        url: $(@).attr('href')
        method: 'delete'
    false