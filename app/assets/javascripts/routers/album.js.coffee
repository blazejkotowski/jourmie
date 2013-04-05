class Jourmie.Routers.Album extends Backbone.Router
  routes:
    'edit': 'edit'
    '': 'show'
    
  initialize: (album_id) ->  
    @album_id = album_id
    
  edit: ->
    Window.album = new Jourmie.Models.Album({ id: @album_id })
    Window.album.fetch
      complete: @editRender
    
  editRender: ->
    editView = new Jourmie.Views.Albums.Edit({ model: Window.album })
    $('#album-container').html(editView.render().$el)
