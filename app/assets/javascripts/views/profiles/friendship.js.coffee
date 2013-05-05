class Jourmie.Views.Profiles.Friendship extends Backbone.View
  model: 'Jourmie.Models.Friendship'
  template: JST['profiles/friendship']

  render: ->
    console.log @model.toJSON()
    @$el.html(@template(@model.toJSON()))
    @
