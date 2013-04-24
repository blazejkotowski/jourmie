class Jourmie.Models.Place extends Backbone.RelationalModel

  initialize: ->
    null
      
  latlng: ->
    "#{@get('latitude')},#{@get('longitude')}"
    
Jourmie.Models.Place.setup()
