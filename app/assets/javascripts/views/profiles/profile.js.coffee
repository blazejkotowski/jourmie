class Jourmie.Views.Profiles.Profile extends Backbone.View
  model: 'Jourmie.Models.Profile'
  tagName: 'div'
  template: JST['profiles/profile']
  
  events:
    "click .add-friend": "addFriend"
  
  render: ->
    @$el.html(@template(@model.toTemplate()))
    @
    
  addFriend: (event) ->
    event.preventDefault()
    url = $(event.target).attr('href')
    $.post url, {}, (data) ->
      if data.message
        Helpers.prettyAlert(data.message)
      else if data.error
        Helpers.prettyAlert(data.error)
    
