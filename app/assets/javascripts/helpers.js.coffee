window.Helpers =
  dateString: (date, number = false) ->
    months = Array('January','February','March','April','May', 'June','July','August','September','October','November','December')
    day = ('0' + date.getDate()).slice(-2)
    if number
      month = ('0' + (date.getMonth() + 1)).slice(-2)
    else
      month = months[date.getMonth()]
    year = date.getFullYear()
    "#{month}/#{day}/#{year}"

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
  
  setBodyBackground: (src) ->
    Window.last_background = $('body').css('background-image')
    $('body').css('background-image', src)
    
  restoreBodyBackground: ->
    if Window.last_background
      $('body').css('background-image', Window.last_background)
      Window.last_background = undefined
