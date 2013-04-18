window.Jourmie =
  Models: {}
  Collections: {}
  Views: 
    Albums: {}
  Routers: {}
  initialize: -> 
    console.log 'Hello from Backbone!'
  
  albumInitialize: (album_id) ->
    router = new Jourmie.Routers.Album(album_id)
    Backbone.history.start()
    
  setTitle: (title = '') ->
    $('.navbar-notification').last().html("<h2>#{title}</h2>")
    if title == ''
      document.title = 'Jourmie'
    else
      document.title = "#{title} | Jourmie"
      
$(document).ready ->
  Jourmie.initialize()
