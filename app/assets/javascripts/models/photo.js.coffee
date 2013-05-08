class Jourmie.Models.Photo extends Backbone.RelationalModel
  
  relations: [
    {
      key: 'comments'
      type: Backbone.HasMany
      relatedModel: 'Jourmie.Model.Comment'
      collectionType: 'Jourmie.Collections.Comments'
      reverseRelation:
        key: 'photo'
        keySource: 'photo_id'
        type: Backbone.HasOne
        includeInJSON: 'id'
    }
  ]

  toTemplate: ->
    _.clone(@attributes)
