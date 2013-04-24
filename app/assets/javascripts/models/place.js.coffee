class Jourmie.Models.Place extends Backbone.RelationalModel

  initialize: ->
    @on "sync", @syncEvent
  
  latlng: ->
    "#{@get('latitude')},#{@get('longitude')}"
    
  parse: (response, options) ->
    if response.status.code == 200
      response.place
    else
      {}
    
Jourmie.Models.Place.setup()
