class Jourmie.Models.Road extends Backbone.RelationalModel
  relations: [
    {
      key: 'place_from'
      type: Backbone.HasOne
      model: 'Jourmie.Models.Place'
      reverseRelation:  
        key: 'road_to'
        type: Backbone.HasOne
    },
    {
      key: 'place_to'
      type: Backbone.HasOne
      model: 'Jourmie.Models.Place'
      reverseRelation:  
        key: 'road_from'
        type: Backbone.HasOne
    },
  ]
  
Jourmie.Models.Road.setup()
