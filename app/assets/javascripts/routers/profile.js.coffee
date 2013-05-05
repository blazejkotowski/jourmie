class Jourmie.Routers.Profile extends Backbone.Router
  routes:
    '': 'albums'
    'albums': 'albums'
    'buddies': 'buddies'
    
  initialize: ->
    Jourmie.setTitle "#{Window.profile.get('display_name')}'s profile"
    @profileView = new Jourmie.Views.Profiles.Profile({ model: Window.profile })
    $(".transparent-wrapper").html(@profileView.render().$el)
      
  albums: ->
    albumsView = new Jourmie.Views.Albums.Index({ model: Window.profile.get('user').get('albums') })
    @profileView.$el.find('.profile-body').html(albumsView.render().$el)
    
  buddies: ->
    _.bindAll(this, "buddiesRender")
    @friendships = new Jourmie.Collections.Friendships(Window.profile.get('permalink'))
    @friendships.fetch
      complete: @buddiesRender
  
  buddiesRender: ->
    buddiesView = new Jourmie.Views.Profiles.Friendships({ collection: @friendships })
    @profileView.$el.find('.profile-body').html(buddiesView.render().$el)
