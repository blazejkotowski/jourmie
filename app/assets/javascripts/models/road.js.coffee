class Jourmie.Models.Road extends Backbone.RelationalModel
  
  url: ->
    if @get('id') isnt undefined
      "/roads/#{@get('id')}"
    else
      "/roads"
      
  relations: [
    {
      key: 'album'
      relatedModel: 'Jourmie.Models.Album'
      includeInJSON: 'id'
      keySource: 'album_id'
      type: Backbone.HasOne
      reverseRelation:
        key: 'roads'
        includeInJSON: 'id'
        keySource: 'road_id'
        type: Backbone.HasMany
    },
    {
      key: 'place_from'
      includeInJSON: 'id'
      keySource: 'place_from_id'
      type: Backbone.HasOne
      relatedModel: 'Jourmie.Models.Place'
      reverseRelation:
        key: 'road_to'
        includeInJSON: 'id'
        keySource: 'road_to_id'
        type: Backbone.HasOne
    },
    {
      key: 'place_to'
      includeInJSON: 'id'
      keySource: 'place_to_id'
      type: Backbone.HasOne
      relatedModel: 'Jourmie.Models.Place'
      reverseRelation:
        key: 'road_from'
        includeInJSON: 'id'
        keySource: 'road_from_id'
        type: Backbone.HasOne
    },
    {
      key: 'photos'
      relatedModel: 'Jourmie.Models.Photo'
      type: Backbone.HasMany
      collectionType: 'Jourmie.Collections.Photos'
      reverseRelation:
        keySource: 'road_id'
        includeInJSON: 'id'
        key: 'road'
        type: Backbone.HasOne
    }
 
  ]
  
  toTemplate: ->
    _.clone(@attributes)
  
  
Jourmie.Models.Road.setup()
