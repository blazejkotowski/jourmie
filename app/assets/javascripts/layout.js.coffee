jQuery ->
  @setFooterAndWrapper= ->
    notificationBottom = $(".navbar-notification").last().offset().top + $(".navbar-notification").outerHeight()
    footerTop = $("footer").offset().top
    console.log "notificationBottom", notificationBottom, "footerTop", footerTop
    heightSpace = footerTop - notificationBottom
    
    $wrapper = $(".transparent-wrapper")
    wrapperHeight = $wrapper.outerHeight()
    
    if $wrapper.length && wrapperHeight < heightSpace
      $wrapper.css
        position: "absolute"
        top: "50%"
        "margin-top": -wrapperHeight/2 + 20
    else
      $wrapper.css
        "margin-top": -10
    
    if $wrapper.length
      $("footer").css
        position: "absolute"
        bottom: 0
        right: 0
        left: 0
      if $("footer").offset().top < $wrapper.offset().top + wrapperHeight
        $("footer").css
          bottom: "auto"
          top: $wrapper.offset().top + wrapperHeight
      
        
    
  @replaceDatepickerArrows= ->
    $ia = $(".datepicker .icon-arrow-right")
    $parent = $ia.parent()
    $ia.remove()
    $parent.html('&gt;')
    
    $ia = $(".datepicker .icon-arrow-left")
    $parent = $ia.parent()
    $ia.remove()
    $parent.html('&lt;')
  
  notificationsHidden = false
  @toggleNotifications= ->
    if ($(window).scrollTop() > 10 && !notificationsHidden) || ($(window).scrollTop() <= 0 && notificationsHidden)
      notificationsHidden = !notificationsHidden
      $(".navbar-notification:not(.placeholder)").slideToggle(100)

  $(".datepicker-wrapper").datepicker().on "changeDate", (e) ->
    $($(@).data("target")).val($(@).data("date"))
  $(".datepicker-wrapper").trigger("changeDate")
  @replaceDatepickerArrows()
  
  $(window).scroll @toggleNotifications
  
  $("#shutter button.jr-close").on "click", (e) ->
    Helpers.hideShutter()
    e.preventDefault()
