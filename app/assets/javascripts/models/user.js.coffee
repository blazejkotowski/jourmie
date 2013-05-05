class Jourmie.Models.User extends Backbone.RelationalModel

  relations: [
    {
      key: 'albums'
      type: Backbone.HasMany
      collectionType: 'Jourmie.Collections.Albums'
      relatedModel: 'Jourmie.Models.Album'
    },
  ]
  
Jourmie.Models.User.setup()
