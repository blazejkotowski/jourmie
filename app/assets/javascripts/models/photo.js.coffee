class Jourmie.Models.Photo extends Backbone.RelationalModel
  
  toTemplate: ->
    _.clone(@attributes)
