class Jourmie.Models.Road extends Backbone.RelationalModel
  relations: [
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
  ]
  
  toTemplate: ->
    _.clone(@attributes)
  
  
Jourmie.Models.Road.setup()
