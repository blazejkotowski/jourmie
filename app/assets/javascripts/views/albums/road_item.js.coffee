class Jourmie.Views.Albums.RoadItem extends Backbone.View
  
  model: 'Jourmie.Models.Road'
  template: JST['albums/road_item']
  
  render: ->
    @$el.html($(@template(@model.toTemplate())))
    @
    
