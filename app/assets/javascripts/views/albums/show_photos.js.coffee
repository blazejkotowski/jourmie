class Jourmie.Views.Albums.ShowPhotos extends Backbone.View
  collection: 'Jourmie.Collections.Photos'
  template_big: JST['albums/show_photos_big']
  template_thumbs: JST['albums/show_photos_thumbs']
  
  events:
    'click .photo-wrapper img': 'openPhoto'

  render: ->
    @$el.html('')
    i = 0
    big = true
    models = @collection.toJSON()
    while(i < models.length)
      content = models.slice(i, i+10)
      # Add indexes to single elements to identify them
      _.each content, (el, index) -> el.index = i + index
      template = if big then @template_big else @template_thumbs
      big = !big
      @$el.append(template({ photos: content }))
      i += 10
    @
    
  openPhoto: (event) ->
    event.preventDefault()
    id = $(event.target).data('id')
    photoModel = @collection.at(id)
    photoView = new Jourmie.Views.Photos.PhotoPreview({ model: photoModel })
    console.log "opening photo", photoModel
    Helpers.setLightShutterBody(photoView.render().$el)
    Helpers.showLightShutter()

