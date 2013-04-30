class Jourmie.Views.Albums.PlaceItem extends Backbone.View
  
  model: 'Jourmie.Models.Place'
  template: JST['albums/place_item']
  
  events:
    'click a.photo': "openPhotosManager"
  
  render: ->
    _.bindAll this, "renderMap", "render"
    @$el.html($(@template(@model.toTemplate())))
    @
    
  renderMap: ->
    map = L.map @$el.find(".place-map").get(0), { dragging: false, scrollWheelZoom: false }
    map.setView([@model.get('latitude'), @model.get('longitude')], 12)
    layer = L.tileLayer 'http://{s}.tile.cloudmade.com/dc1a3c801e2d4ab3a281fff2dd1d61e2/997/256/{z}/{x}/{y}.png', { attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>', maxZoom: 18 }
    layer.addTo(map)
    
  openPhotosManager: (e) ->
    Helpers.showShutter()
    Helpers.setShutterTitle "Adding photos to #{@model.get('name')}"
    photos_manager = new Jourmie.Views.Albums.PhotosManager({ model: @model })
    Helpers.setShutterBody(photos_manager.render().$el)
    e.preventDefault()
    
