window.Helpers =
  dateString: (date) ->
    day = ('0' + date.getDate()).slice(-2)
    month = ('0' + (date.getMonth()+1)).slice(-2)
    year = date.getFullYear()
    "#{month}/#{day}/#{year}"
