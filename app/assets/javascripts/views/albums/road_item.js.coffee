class Jourmie.Views.Albums.RoadItem extends Backbone.View
  
  model: 'Jourmie.Models.Road'
  template: JST['albums/road_item']
  
  events:
    'click .transport li a': 'chooseMeans'
    'click a.photo': 'openPhotosManager'
  
  render: ->
    @$el.html($(@template(@model.toTemplate())))
    @
    
  chooseMeans: (event) ->
    console.log "means"
    @$el.find('.transport .active').removeClass('active')
    console.log "setting ",$(event.target).attr('href'), " means"
    @model.save { means: $(event.target).attr('href') }, { patch: true }
    $(event.target).parent().addClass('active')

    event.preventDefault()
    
  openPhotosManager: (e) ->
    e.preventDefault()
    Helpers.showShutter()
    Helpers.setShutterTitle "Adding photos to road #{@model.get('place_from').get('name')} - #{@model.get('place_to').get('name')}"
    photos_manager = new Jourmie.Views.Albums.PhotosManager({ model: @model })
    Helpers.setShutterBody(photos_manager.render().$el)
 
