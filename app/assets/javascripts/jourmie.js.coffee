jQuery ->
  @replaceDatepickerArrows= ->
    $ia = $(".datepicker .icon-arrow-right")
    $parent = $ia.parent()
    $ia.remove()
    $parent.html('&gt;')
    
    $ia = $(".datepicker .icon-arrow-left")
    $parent = $ia.parent()
    $ia.remove()
    $parent.html('&lt;')

  $(".datepicker-wrapper").datepicker()
  @replaceDatepickerArrows()
