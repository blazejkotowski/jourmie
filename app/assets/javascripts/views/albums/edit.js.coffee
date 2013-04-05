class Jourmie.Views.Albums.Edit extends Backbone.View
  
  template: JST['albums/edit']
  model: 'Jourmie.Models.Album'
  
  initialize: ->
    _.bindAll(this,'render')
  
  render: ->
    @$el.html(@template(@model.toJSON()))
    @
