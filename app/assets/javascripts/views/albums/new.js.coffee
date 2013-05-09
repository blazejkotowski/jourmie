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
  
  render: ->
    @$el.html(@template(@model.toTemplate()))
    Jourmie.setTitle('Creating new album')
    @$el.find("#invite-modal").modal
      show: false
      keyboard: true
    @
    
  changeStartDate: (e) ->
    @model.set 'start_date', e.date
    
  changeEndDate: (e) ->
    @model.set 'end_date', e.date
  
  changeName: (e) ->
    @model.set 'name', $(e.target).val()
    
  inviteFriends: (e) ->
    e.preventDefault()
    if $(e.target).hasClass('jourmie')
      @inviteFromJourmie()
  
  inviteFromJourmie: ->
    $list = $(JST['friendships/autocomplete']())
    source = _.map Window.friendships.toJSON(), (o) -> { data: o, value: o.friend.profile.display_name, label: o.friend.profile.display_name }
    @$el.find("#invite-modal .modal-body").html($list)
    $el = @$el
    @$el.find('.friendships-autocomplete').autocomplete
      minLength: 1
      source: source
      select: (e, ui) ->
        friend = ui.item.data.friend
        $removeButton = $("<button/>").addClass("btn btn-medium btn-primary remove-participant")
                                      .text("Delete")
                                      .attr("data-id", friend.id)
        $friendItem = $("<div/>").addClass("friend")
                  .append($("<img/>").addClass('avatar').attr('src', friend.profile.avatar.small))
                  .append($("<div/>").addClass('name').html("<div>#{friend.profile.display_name#}</div>").append($removeButton))
                  .append($("<div/>").addClass("clearer"))
        new_participation = new Jourmie.Models.Participation
          album_id: Window.album.get('id')
          user_id: ui.item.data.friend_id
        console.log ui.item.data
        Window.album.get('participations').add new_participation
        $el.find(".chosen-friendships").append($friendItem)
        
    @$el.find("#invite-modal").modal('show')
    
  saveAlbum: (e) ->
    participants_to_save = Window.album.get('participations').length
    Window.album.save {},
      success: ->
        console.log "Album saved"
        for participation in Window.album.get('participations').models
          participation.save {},
            success: -> 
              if (--participants_to_save) <= 0
                window.location.href = window.location.origin + "/albums/#{Window.album.get('slug')}#edit"
              
              
