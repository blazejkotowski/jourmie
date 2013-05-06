class Jourmie.Views.Albums.ShowPhotos extends Backbone.View
  collection: 'Jourmie.Collections.Photos'
  template_big: JST['albums/show_photos_big']
  template_thumbs: JST['albums/show_photos_thumbs']
  
  render: ->
    @$el.html('')
    i = 0
    big = true
    models = @collection.toJSON()
    while(i < models.length)
      content = models.slice(i, i+10)
      template = if big then @template_big else @template_thumbs
      big = !big
      @$el.append(template({ photos: content }))
      i += 10
    @
    
