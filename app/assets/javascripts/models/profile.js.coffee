class Jourmie.Models.Profile extends Backbone.RelationalModel
  
  url: -> "/profiles/#{@get('id')}.json"
  
  relations: [
    {
      key: 'user'
      relatedModel: 'Jourmie.Models.User'
      type: Backbone.HasOne
    }
  ]
  
  toTemplate: ->
    _.clone(@attributes)
    
Jourmie.Models.Profile.setup()
