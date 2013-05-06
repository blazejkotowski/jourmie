class Jourmie.Views.Albums.Participants extends Backbone.View
  collection: 'Jourmie.Collections.Participants'
  template: JST['albums/participants']
  
  render: ->
    @$el.html(@template(participants: @collection.toJSON()))
    @
  
