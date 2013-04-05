class Jourmie.Models.Place extends Backbone.RelationalModel
  relations: [
    {
      key: 'road_to'
      type: Backbone.HasOne
      relatedModel: 'Jourmie.Models.Road'
      reverseRelation:
        key: 'place_from'
        type: Backbone.HasOne
    },
    {
      key: 'road_from'
      type: Backbone.HasOne
      relatedModel: 'Jourmie.Models.Road'
      reverseRelation:
        key: 'place_to'
        type: Backbone.HasOne
    }
  ]
  
Jourmie.Models.Place.setup()
