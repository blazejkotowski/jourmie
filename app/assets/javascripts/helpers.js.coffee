window.Helpers =
  dateString: (date) ->
    months = Array('January','February','March','April','May', 'June','July','August','September','October','November','December')
    day = ('0' + date.getDate()).slice(-2)
    month = months[date.getMonth()]
    year = date.getFullYear()
    "#{day}/#{month}/#{year}"
    
  prettyAlert: (message) ->
    alert(message)
    
  showShutter: ->
    $("#shutter").fadeIn(100)
    $("#main-container").hide()
    
  hideShutter: ->
    $("#main-container").show()
    $("#shutter").fadeOut(100)
    
  setShutterTitle: (title) ->
    $("#shutter #shutter-header").text(title)
    
  setShutterBody: (body) -> 
    $("#shutter #shutter-body").html(body)
    
