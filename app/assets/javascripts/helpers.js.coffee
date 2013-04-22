window.Helpers =
  dateString: (date) ->
    months = Array('January','February','March','April','May', 'June','July','August','September','October','November','December')
    day = ('0' + date.getDate()).slice(-2)
    month = months[date.getMonth()]
    year = date.getFullYear()
    "#{day}/#{month}/#{year}"
