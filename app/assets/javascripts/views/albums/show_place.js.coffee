class Jourmie.Views.Albums.ShowPlace extends Backbone.View
  model: 'Jourmie.Models.Place'
  template: JST['albums/show_place']
  className: 'show-place'
  
  render: ->
    @$el.html(@template(@model.toJSON()))
    @
    
  renderMaps: ->
    big_map = L.map @$el.find(".place-map").get(0), { dragging: false, scrollWheelZoom: false }
    big_map.setView([@model.get('latitude'), @model.get('longitude')], 12)
    
    small_map = L.map @$el.find('.info-map').get(0), { dragging: false, scrollWheelZoom: false }
    small_map.setView([@model.get('latitude'), @model.get('longitude')], 13)

    layer_small = L.tileLayer 'http://{s}.tile.cloudmade.com/dc1a3c801e2d4ab3a281fff2dd1d61e2/997/256/{z}/{x}/{y}.png',{ maxZoom: 18 }
    layer_big = L.tileLayer 'http://{s}.tile.cloudmade.com/dc1a3c801e2d4ab3a281fff2dd1d61e2/997/256/{z}/{x}/{y}.png', { attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>', maxZoom: 18 }
    
    layer_small.addTo(small_map)
    layer_big.addTo(big_map)
    
    
