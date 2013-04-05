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

$(document).ready ->
  Jourmie.initialize()
