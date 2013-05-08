window.Helpers =
  dateString: (date) ->
    months = Array('January','February','March','April','May', 'June','July','August','September','October','November','December')
    day = ('0' + date.getDate()).slice(-2)
    month = months[date.getMonth()]
    year = date.getFullYear()
    "#{day}/#{month}/#{year}"

  datetimeString: (date) ->
    hour = ('0' + date.getHours()).slice(-2)
    minutes = ('0' + date.getMinutes()).slice(-2)
    seconds = ('0' + date.getSeconds()).slice(-2)
    @dateString(date) + " #{hour}:#{minutes}:#{seconds}"

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

  showLightShutter: ->
    $("#light-shutter").fadeIn(100)

  hideLightShutter: ->
    $("#light-shutter").fadeOut(100)

  setLightShutterBody: (body) ->
    $("#light-shutter").html(body)
    
