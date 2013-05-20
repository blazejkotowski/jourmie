class Jourmie.Views.Participations.ParticipantsManager extends Backbone.View

  template: JST['participations/participants_manager']
  tagName: 'div'
  collection: 'Jourmie.Collections.Participations'

  events:
    'click .remove-participant': 'removeParticipant'
 
  render: ->
    @$el.html(@template(@collection.toJSON()))
    $el = @$el
    console.log @autocompleteSource
    autocomplete = @$el.find('.friendships-autocomplete-input').autocomplete
      source: @autocompleteSource
      minLength: 1
      select: (e, ui) ->
        friend = ui.item.data.friend
        friend.index = Window.album.get('participations').length + 1
        $friendItem = $(JST['participations/friend_item'](friend))
        new_participation = new Jourmie.Models.Participation
          album: Window.album
          user_id: ui.item.data.friend_id
        Window.album.get('participations').add new_participation
        console.log "album,", Window.album
        if Window.album.get('id') is undefined
          Window.album.save {},
            success: ->
              console.log "new participation, ", new_participation
              new_participation.set('album', Window.album)
              new_participation.save()
        else
          console.log "saving new participation"
          new_participation.save()
        $el.find(".chosen-friendships").append($friendItem)
    autocomplete.data("ui-autocomplete")._renderItem = (ul, item) ->
      console.log item
      $item = $("<li/>").append("<a><img src=\"#{item.data.friend.profile.avatar.tiny}\">#{item.label}</a>").appendTo(ul)

    @renderParticipants()
    @

  removeParticipant: (event) ->
    event.preventDefault()
    id = $(event.target).data('id')-1
    participation = Window.album.get('participations').at(id)
    if participation.get('id') isnt undefined
      participation.destroy()
    Window.album.get('participations').remove(participation)
    $(event.target).closest('.friend').remove()

  renderParticipants: ->
    i = 1
    for participation in Window.album.get('participations').models
      attributes = participation.toJSON()
      attributes.index = i
      console.log attributes
      i += 1
      $friendItem = $(JST['participations/friend_item'](attributes))
      @$el.find('.chosen-friendships').append($friendItem)
