class Jourmie.Views.Albums.Show extends Backbone.View
  model: 'Jourmie.Models.Album'
  template: JST['albums/show']
  className: 'album-show'
  tagName: 'div'
  
  render: ->
    @$el.html(@template(@model.toJSON()))
    $("body").css("background-image", 'url("/assets/backgrounds/Tło3.jpg")')
    @
    
  renderPlaces: ->
    for place in @model.get('places').models
      placeView = new Jourmie.Views.Albums.ShowPlace({ model: place })
      @$el.find('.transparent-wrapper').append(placeView.render().$el)
      placeView.renderMaps()
      placeView.renderContent()
    
  
