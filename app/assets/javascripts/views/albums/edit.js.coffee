class Jourmie.Views.Albums.Edit extends Backbone.View
  
  template: JST['albums/edit']
  model: 'Jourmie.Models.Album'
  
  events:
    'click .add-place': 'addPlace'
    'geocode:result .gmaps': 'keepCurrentLocation'
  
  initialize: ->
    _.bindAll(this,'render')
  
  render: ->
    @$el.html(@template(@model.toJSON()))
    @
    
  addPlace: (e) ->
    new_place = new Jourmie.Models.Place
      latlang: @current_place_location, 
      name: @current_place_name, 
      date_from: "data od"
      date_to: "data do"
    $place_view = $(JST['albums/place_item'](new_place.toJSON()))
    map = L.map $place_view.find(".place-map").get(0), { dragging: false, scrollWheelZoom: false }
    map.setView(@current_place_location, 12)
    layer = L.tileLayer 'http://{s}.tile.cloudmade.com/dc1a3c801e2d4ab3a281fff2dd1d61e2/997/256/{z}/{x}/{y}.png', { attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>', maxZoom: 18 }
    layer.addTo(map)
    @$el.find("#new-place").before($place_view)
    $('#place_address').val('')
    e.preventDefault()
    
  keepCurrentLocation: (e, result) ->
    @current_place_name = result.name
    @current_place_location = [result.geometry.location.jb, result.geometry.location.kb]
