class Jourmie.Models.Place extends Backbone.RelationalModel

  initialize: ->
    null
      
  latlng: ->
    "#{@get('latitude')},#{@get('longitude')}"
    
  parse: (response, options) ->
    if response.status.code == 200 && response.place
      response.place
    else
      {}
    
Jourmie.Models.Place.setup()
