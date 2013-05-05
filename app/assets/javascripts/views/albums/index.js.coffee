class Jourmie.Views.Albums.Index extends Backbone.View
  model: 'Jourmie.Collections.Albums'
  template: JST['albums/index']
  
  render: ->
    @$el.html(@template({ albums: @model.toJSON() }))
    @
  
