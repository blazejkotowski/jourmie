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
  
  parse: (response, options) ->
    if response.status.code == 200 && response.road
      response.road
    else
      {}
    
  
Jourmie.Models.Road.setup()
