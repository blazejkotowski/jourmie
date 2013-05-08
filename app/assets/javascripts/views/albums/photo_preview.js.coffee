class Jourmie.Views.Albums.PhotoPreview extends Backbone.View
  
  model: 'Jourmie.Models.Photo'
  tagName: 'div'
  className: 'photo-preview'
  template: JST['albums/photo_preview']

  events:
    'click .jr-close': 'closePreview'

  render: ->
    @$el.html(@template(@model.toJSON()))
    @

  closePreview: (e) ->
    e.preventDefault()
    Helpers.hideLightShutter()
    Helpers.setLightShutterBody('')
