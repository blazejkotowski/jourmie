class Jourmie.Models.Place extends Backbone.RelationalModel

  initialize: ->
    null
      
  latlng: ->
    "#{@get('latitude')},#{@get('longitude')}"
    
  parse: (response, options) ->
    response.date_from = new Date(response.date_from)
    response.date_to = new Date(response.date_to)
    response
    
  toTemplate: ->
    attrs = _.clone(@attributes)
    
Jourmie.Models.Place.setup()
