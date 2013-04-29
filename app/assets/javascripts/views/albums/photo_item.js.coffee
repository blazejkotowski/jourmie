class Jourmie.Views.Albums.PhotoItem extends Backbone.View

  model: 'Jourmie.Models.Photo'
  tagName: 'div'
  className: 'photo-item'
  template: JST['albums/photo_item']
  
  render: ->
    @$el.html(@template(@model.toTemplate()))
    @
