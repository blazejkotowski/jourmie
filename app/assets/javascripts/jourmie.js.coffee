window.Jourmie =
  Models: {}
  Collections: {}
  Views: 
    Albums: {}
    Profiles: {}
  Routers: {}
  initialize: -> 
    console.log 'Hello from Backbone!'
  
  albumInitialize: (album_id) ->
    router = new Jourmie.Routers.Album(album_id)
    Backbone.history.start()
    
  profileInitialize: (profile_id) ->
    Window.profile = new Jourmie.Models.Profile({ id: profile_id })
    Window.profile.fetch
      complete: @profileRouterInitialize
  
  profileRouterInitialize: -> 
    router = new Jourmie.Routers.Profile()
    Backbone.history.start()
    
  setTitle: (title = '') ->
    if title == ''
      document.title = 'Jourmie'
    else
      unless $('.navbar-notification.navbar-title').length > 0
        $('.navbar-notification.placeholder').after('<div class="navbar-notification navbar-title"></div>')
      $('.navbar-notification.navbar-title').html("<h2>#{title}</h2>")
      document.title = "#{title} | Jourmie"
      
$(document).ready ->
  Jourmie.initialize()
