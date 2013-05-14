class Jourmie.Views.Albums.New extends Backbone.View
  model: 'Jourmie.Models.Album'
  className: 'container'
  tagName: 'div'
  template: JST['albums/new']
  
  events: ->
    'changeDate #start-date-picker': 'changeStartDate'
    'changeDate #end-date-picker': 'changeEndDate'
    'change #album_name': 'changeName'
    'click .social-icon': 'inviteFriends'
    'click #submit': 'saveAlbum'
    'click .remove-participant': 'removeParticipant'
  
  render: ->
    @$el.html(@template(@model.toTemplate()))
    Jourmie.setTitle('Creating new album')
    @$el.find("#invite-modal").modal
      show: false
      keyboard: true
    @
    
  changeStartDate: (e) ->
    if e.date
      @model.set 'start_date', e.date
    
  changeEndDate: (e) ->
    if e.date
      @model.set 'end_date', e.date
  
  changeName: (e) ->
    console.log $("#album_name").val()
    @model.set 'name', $("#album_name").val()
    
  inviteFriends: (e) ->
    e.preventDefault()
    if $(e.target).hasClass('jourmie')
      @inviteFromJourmie()
  
  inviteFromJourmie: ->
    $list = $(JST['friendships/autocomplete']())
    source = _.map Window.friendships.toJSON(), (o) -> { data: o, value: o.friend.profile.display_name, label: o.friend.profile.display_name }
    @$el.find("#invite-modal .modal-body").html($list)
    $el = @$el
    if source.length < 1
      @$el.find('.friendships-autocomplete').html("You have no friends yet. Please use search field in top navigation bar to find and add your Jourmie friends")
    else
      autocomplete = @$el.find('.friendships-autocomplete-input').autocomplete
        minLength: 1
        source: source
        select: (e, ui) ->
          friend = ui.item.data.friend
          $removeButton = $("<button/>").addClass("btn btn-medium btn-primary remove-participant")
                                        .text("Delete")
          $friendItem = $("<div/>").addClass("friend")
                    .append($("<img/>").addClass('avatar').attr('src', friend.profile.avatar.small))
                    .append($("<div/>").addClass('name').html("<div>#{friend.profile.display_name}</div>").append($removeButton))
                    .append($("<div/>").addClass("clearer"))
          new_participation = new Jourmie.Models.Participation
            album_id: Window.album.get('id')
            user_id: ui.item.data.friend_id
          Window.album.get('participations').add new_participation
          $removeButton.attr("data-id", Window.album.get('participations').length)
          $el.find(".chosen-friendships").append($friendItem)
      autocomplete.data("ui-autocomplete")._renderItem = (ul, item) ->
        console.log item
        $item = $("<li/>").append("<a><img src=\"#{item.data.friend.profile.avatar.tiny}\">#{item.label}</a>").appendTo(ul)
        
    @$el.find("#invite-modal").modal('show')
    
  saveAlbum: (e) ->
    participants_to_save = Window.album.get('participations').length
    Window.album.save {},
      success: ->
        console.log "Album saved"
        console.log 'album_slug',Window.album.get('slug')
        if Window.album.get('participations').length > 0
          for participation in Window.album.get('participations').models
            participation.save {},
              success: ->
                if (--participants_to_save) <= 0
                  window.location = "/albums/#{Window.album.get('slug')}#edit"
        else
          window.location = "/albums/#{Window.album.get('slug')}#edit"


   removeParticipant: (event) ->
     event.preventDefault()
     id = $(event.target).data('id')-1
     participation = @model.get('participations').at(id)
     @model.get('participations').remove(participation)
     $(event.target).closest('.friend').remove()
