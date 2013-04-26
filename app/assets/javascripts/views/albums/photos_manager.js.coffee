class Jourmie.Views.Albums.PhotosManager extends Backbone.View
  
  template: JST['albums/photos_manager']
  
  events:
    'click .folder-area': 'addPhotos'
  
  render: ->
    @$el.html(@template())
    @
    
  addPhotos: (e) ->
    console.log "clicked folder area"
    e.preventDefault()
