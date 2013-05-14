class Jourmie.Routers.Album extends Backbone.Router
  routes:
    'edit': 'edit'
    '': 'show'
    'show': 'show'
    
  show: ->
    Jourmie.setTitle Window.album.get('name')
    Jourmie.removeNavbarTitle()
    Helpers.hideNavbar()
    showView = new Jourmie.Views.Albums.Show({ model: Window.album })
    $("#album-wrapper").html(showView.render().$el)
    showView.renderPlaces()
    
  edit: ->
    Jourmie.setTitle 'Edit album'
    Helpers.showNavbar()
    editView = new Jourmie.Views.Albums.Edit({ model: Window.album })
    $('#album-wrapper').html(editView.render().$el)
    editView.renderRelated()
    editView.setLastDate()
    # editView.$el.find('.datepicker').datepicker('hide')
