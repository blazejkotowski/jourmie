class Jourmie.Models.Place extends Backbone.RelationalModel
  
  relations: [
    {
      key: 'photos'
      relatedModel: 'Jourmie.Models.Photo'
      type: Backbone.HasMany
      collectionType: 'Jourmie.Collections.Photos'
      reverseRelation:
        keySource: 'place_id'
        includeInJSON: 'id'
        key: 'place'
        type: Backbone.HasOne
    }
  ]
  
  url: ->
    if @get('id') isnt undefined
      "/places/#{@get('id')}"
    else
      "/places"
  
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
