class Jourmie.Models.Album extends Backbone.RelationalModel
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
