class Jourmie.Views.Albums.Show extends Backbone.View
  model: 'Jourmie.Models.Album'
  template: JST['albums/show']
  className: 'album-show'
  tagName: 'div'
  
  render: ->
    @$el.html(@template(@model.toJSON()))
    @
