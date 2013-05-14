class Jourmie.Views.Albums.Edit extends Backbone.View
  
  template: JST['albums/edit']
  model: 'Jourmie.Models.Album'
  className: 'transparent-wrapper'
  
  events:
    'click .add-place': 'addPlace'
    'geocode:result .gmaps': 'keepCurrentLocation'
    'changeDate .datepicker': 'changeDate'
    'slid .carousel': 'changeCoverPhoto'
    'click #finish-button': 'saveChanges'
    'blur #album-title': 'changeName'
    'click .place-buttons:not(".transport") a:not(".photo")': (e) -> e.preventDefault()
  
  initialize: ->
    _.bindAll(this,'render')
  
  render: ->
    @$el.html(@template(@model.toJSON()))
    Helpers.restoreBodyBackground()
    @$el.find('.datepicker').datepicker()
    @$el.find('.gmaps').geocomplete()
    @$el.find('.carousel').carousel('pause')
    @$el.find('.datepicker').datepicker('hide')
    @

  setLastDate: ->
    if @model.get('places').length > 0
      last_date = @model.get('places').at(@model.get('places').length-1).get('date_to')
    else
      last_date = new Date(@model.get('start_date'))
    @$el.find('#date_from').val(Helpers.dateString(last_date, true)).focus().blur()
    @$el.find('#date_from').datepicker('hide')
    @$el.find('#date_to').datepicker('hide')

  addPlace: (e) ->
    new_place = new Jourmie.Models.Place
      latitude: @current_place_location[0]
      longitude: @current_place_location[1]
      name: @current_place_name
      date_from: new Date($("#date_from").val())
      date_to: new Date($("#date_to").val())
    
    new_road = @model.addPlace new_place
    if new_road
      @appendRoad(new_road)
    
    @appendPlace(new_place)
    
    $('#place_address').val('')
    $('#date_from').val($("#date_to").val()).focus().blur()
    $('#date_to').val('').focus().blur()
    
    e.preventDefault()
    
  changeDate: (event) ->
    $(event.target).datepicker("hide")
    
  changeCoverPhoto: (event) ->
    @model.set('cover_image', $('.carousel-inner > .item.active > img').attr('src'))
    @model.set('cover_image_id', $('.carousel-inner > .item.active > img').data('id'))
    
  keepCurrentLocation: (e, result) ->
    @current_place_name = result.name
    console.log "result", result
    @current_place_location = [result.geometry.location.kb, result.geometry.location.lb]
    
  changeName: (event) ->
    @model.set('name', $(event.target).val())
    
  renderRelated: ->
    places_ids = []
    places = @model.get('places').models
    for place in places
      while place isnt null
        if !(place.get('id') in places_ids)
          places_ids.push place.get('id')
          console.log place
          @appendPlace(place)
          if place.get('road_to') isnt null
            @appendRoad(place.get('road_to'))
            place = place.get('road_to').get('place_to')
          else
            place = null
        else
          place = null
  
  appendRoad: (road) ->
    road_view = new Jourmie.Views.Albums.RoadItem({ model: road })
    @$el.find('#new-place').before(road_view.render().$el)
    
  appendPlace: (place) ->
    place_view = new Jourmie.Views.Albums.PlaceItem({ model: place })
    @$el.find('#new-place').before(place_view.render().$el)
    place_view.renderMap()
    
  saveChanges: (event) ->
    event.preventDefault()
    @model.save {},
      success: (model,response) ->
        if response.saved
          Helpers.prettyAlert(response.message)
          window.location.hash = "show"
    
