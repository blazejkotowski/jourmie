class Jourmie.Views.Albums.PhotosManager extends Backbone.View
  
  template: JST['albums/photos_manager']
  model: 'Jourmie.Models.Place'
  
  events:
    'click .folder-area': 'addPhotos'
  
  render: ->
    @$el.html(@template(@model.toTemplate()))
    for photo in @model.get('photos').models
      photo_view = new Jourmie.Views.Albums.PhotoItem({ model: photo })
      @$el.find("#photos").append(photo_view.render().$el)
    place_model = @model
    @$el.find('input[type=file]').fileupload
      dataType: 'json'
      add: (e, data) ->
        photo = new Jourmie.Models.Photo()
        photo_view = new Jourmie.Views.Albums.PhotoItem({ model: photo })
        $el = photo_view.render().$el
        data.context = { model: photo, view: $el }
        $('#photos').append(data.context.view)
        data.submit()
      done: (e, data) ->
        if data.context
          Window.place_model = place_model
          console.log "Add photo to place", place_model
          data.context.model.set data.result
          place_model.get('photos').add data.context.model
      progress: (e, data) ->
        if data.context
          progress = parseInt(data.loaded/data.total * 100, 10)
          data.context.view.find('.bar').css('width', progress + '%')
    @
    
  addPhotos: (e) ->
    console.log "clicked folder area"
#    e.preventDefault()
