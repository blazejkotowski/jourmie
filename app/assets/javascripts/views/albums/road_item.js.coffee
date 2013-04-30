class Jourmie.Views.Albums.RoadItem extends Backbone.View
  
  model: 'Jourmie.Models.Road'
  template: JST['albums/road_item']
  
  events: 
    'click .transport li a': 'chooseMeans'
  
  render: ->
    @$el.html($(@template(@model.toTemplate())))
    @
    
  chooseMeans: (event) ->
    console.log "means"
    @$el.find('.transport .active').removeClass('active')
    console.log $(event.target)
    $(event.target).parent().addClass('active')
    event.preventDefault()
    
