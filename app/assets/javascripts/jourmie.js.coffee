originalSync = Backbone.sync
Backbone.sync = (method, model, options) ->
	if method is "patch"
    options.type = 'PUT'
	originalSync method, model, options

window.Jourmie =
  Models: {}
  Collections: {}
  Views:
    Albums: {}
    Profiles: {}
    Photos: {}
    Participations: {}
  Routers: {}

  initialize: ->
    console.log 'Hello from Backbone!'
  
  albumInitialize: (album_id) ->
    Window.album = new Jourmie.Models.Album({ id: album_id })
    Window.album.fetch
      complete: @albumRouterInitialize

    Window.friendships = new Jourmie.Collections.Friendships()
    Window.friendships.fetch()

    
  albumRouterInitialize: ->
    router = new Jourmie.Routers.Album()
    Backbone.history.start()
    
  profileInitialize: (profile_id) ->
    Window.profile = new Jourmie.Models.Profile({ id: profile_id })
    Window.profile.fetch
      complete: @profileRouterInitialize
  
  profileRouterInitialize: ->
    router = new Jourmie.Routers.Profile()
    Backbone.history.start()
    
  newAlbumInitialize: ->
    Window.album = new Jourmie.Models.Album()
    Jourmie.setTitle 'New Album'
    albumView = new Jourmie.Views.Albums.Edit({ model: Window.album })

    bootbox.prompt "New album name", (result) ->
      if result == null
        result = "No name"
      Window.album.set('name', result)

    $("#album-wrapper").html(albumView.render().$el)
    Window.friendships = new Jourmie.Collections.Friendships()
    Window.friendships.fetch()
    
  setTitle: (title = '') ->
    if title == ''
      document.title = 'Jourmie'
    else
      unless $('.navbar-notification.navbar-title').length > 0
        $('.navbar-notification.placeholder').after('<div class="navbar-notification navbar-title"></div>')
      $('.navbar-notification.navbar-title').html("<h2>#{title}</h2>")
      document.title = "#{title} | Jourmie"
  
  removeNavbarTitle: ->
    $('.navbar-notification.navbar-title').remove()
      
$(document).ready ->
  Jourmie.initialize()
