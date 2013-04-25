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
      Window.road = new_road
      road_view = new Jourmie.Views.Albums.RoadItem({ model: new_road })
      @$el.find("#new-place").before(road_view.render().$el)
    
    place_view = new Jourmie.Views.Albums.PlaceItem({ model: new_place })
    @$el.find("#new-place").before(place_view.render().$el)
    place_view.renderMap()
    
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
      console.log "place_view"
      place_view = new Jourmie.Views.Albums.PlaceItem({ model: place })
      @$el.find('#new-place').before(place_view.render().$el)
      place_view.renderMap()
    
  saveChanges: (event) -> 
    event.preventDefault()
    @model.save {}, 
      success: (model,response) ->
        if response.saved
          Helpers.prettyAlert(response.message)
    
