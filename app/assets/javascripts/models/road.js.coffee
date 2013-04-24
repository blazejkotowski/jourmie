class Jourmie.Models.Road extends Backbone.RelationalModel
  relations: [
    {
      key: 'place_from'
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
      type: Backbone.HasOne
      relatedModel: 'Jourmie.Models.Place'
      reverseRelation:  
        key: 'road_from'
        includeInJSON: 'id'
        keySource: 'road_from_id'
        type: Backbone.HasOne
    },
  ]
  
  
Jourmie.Models.Road.setup()
