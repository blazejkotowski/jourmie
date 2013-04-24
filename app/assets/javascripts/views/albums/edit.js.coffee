class Jourmie.Views.Albums.Edit extends Backbone.View
  
  template: JST['albums/edit']
  model: 'Jourmie.Models.Album'
  
  events:
    'click .add-place': 'addPlace'
    'geocode:result .gmaps': 'keepCurrentLocation'
    'changeDate .datepicker': 'changeDate'
    'slid .carousel': 'changeCoverPhoto'
    'click #finish-button': 'saveChanges'
    'blur #album-title': 'changeName'
  
  initialize: ->
    _.bindAll(this,'render')
  
  render: ->
    @$el.html(@template(@model.toJSON()))
    @$el.find('.datepicker').datepicker()
    @$el.find('.gmaps').geocomplete()
    @$el.find('.carousel').carousel('pause')
    @renderRelated()
    @
    
  addPlace: (e) ->
    new_place = new Jourmie.Models.Place
      latitude: @current_place_location[0],
      longitude: @current_place_location[1]
      name: @current_place_name, 
      date_from: new Date($("#date_from").val())
      date_to: new Date($("#date_to").val())
    
    new_road = @model.addPlace new_place
    if new_road
      $road_view = $(JST['albums/road_item'](new_road.toJSON()))
      @$el.find("#new-place").before($road_view)
    
    $place_view = $(JST['albums/place_item'](new_place.toJSON()))
    @$el.find("#new-place").before($place_view)

    # Rendering map
    map = L.map $place_view.find(".place-map").get(0), { dragging: false, scrollWheelZoom: false }
    map.setView(@current_place_location, 12)
    layer = L.tileLayer 'http://{s}.tile.cloudmade.com/dc1a3c801e2d4ab3a281fff2dd1d61e2/997/256/{z}/{x}/{y}.png', { attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>', maxZoom: 18 }
    layer.addTo(map)
    
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
    @current_place_location = [result.geometry.location.jb, result.geometry.location.kb]
    
  changeName: (event) ->
    @model.set('name', $(event.target).val())
    
  renderRelated: ->
    places = @model.get('places').models
    for place in places
      $place_view = $(JST['albums/place_item'](place.toJSON()))
      console.log place.toJSON()
      @$el.find('#new-place').before($place_view)
    
  saveChanges: (event) -> 
    event.preventDefault()
    @model.save {}, 
      success: (model,response) ->
        if response.saved
          Helpers.prettyAlert(response.message)
    
