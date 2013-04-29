class Jourmie.Views.Albums.PhotosManager extends Backbone.View
  
  template: JST['albums/photos_manager']
  
  events:
    'click .folder-area': 'addPhotos'
  
  render: ->
    @$el.html(@template())
    @$el.find('input[type=file]').fileupload
      dataType: 'json'
      add: (e, data) ->
        photo = new Jourmie.Models.Photo()
        photo_view = new Jourmie.Views.Albums.PhotoItem({ model: photo })
        console.log photo, photo_view
        $el = photo_view.render().$el
        data.context = $el
        $('#photos').append(data.context)
        console.log "added file", data.files[0].name
        data.submit()
      done: (e, data) ->
        if data.context
          data.context.find(".photo-item-image").html($("<img src=\"#{data.result.file}\" />"))
        console.log "uploaded file", data, response
      progress: (e, data) ->
        if data.context
          progress = parseInt(data.loaded/data.total * 100, 10)
          data.context.find('.bar').css('width', progress + '%')
        console.log data
    @
    
  addPhotos: (e) ->
    console.log "clicked folder area"
#    e.preventDefault()
