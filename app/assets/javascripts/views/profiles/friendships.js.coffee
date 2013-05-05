class Jourmie.Views.Profiles.Friendships extends Backbone.View
  tagName: 'div'
  className: 'container'
  idName: 'friendships'
  collection: 'Jourmie.Collection.Friendships'
  
  render: ->
    @$el.html('')
    for friendship in @collection.models
      friendshipView = new Jourmie.Views.Profiles.Friendship({ model: friendship })
      @$el.append(friendshipView.render().$el)
    @
