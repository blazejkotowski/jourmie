class Jourmie.Models.Album extends Backbone.RelationalModel
  
  url: -> "/albums/#{@get('id')}.json"
  
  relations: [
    {
      key: 'places'
      type: Backbone.HasMany
      relatedModel: 'Jourmie.Models.Place'
      reverseRelation:
        key: 'album'
        type: Backbone.HasOne
    }
  ]
  
  initialize: ->
    console.log "New backbone album"
  
  
Jourmie.Models.Album.setup()
