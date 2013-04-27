class Jourmie.Views.Albums.PhotosManager extends Backbone.View
  
  template: JST['albums/photos_manager']
  
  events:
    'click .folder-area': 'addPhotos'
  
  render: ->
    @$el.html(@template())
    @$el.find('input[type=file]').fileupload
      dataType: 'json'
      add: (e, data) ->
        console.log "added file", data.files[0].name
        data.submit()
      done: (e, data) ->
        console.log "uploaded file", data
    @
    
  addPhotos: (e) ->
    console.log "clicked folder area"
#    e.preventDefault()
