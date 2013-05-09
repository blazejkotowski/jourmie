class Jourmie.Views.Albums.PhotoItem extends Backbone.View

  model: 'Jourmie.Models.Photo'
  tagName: 'div'
  className: 'photo-item'
  template: JST['albums/photo_item']
  
  events:
    'click .jr-delete': 'deletePhoto'
    'click .photo-item-buttons a': (e) -> e.preventDefault()
    'blur .description': 'changeDescription'
    
  initialize: ->
    _.bindAll(this, "render")
    @model.on "change", @render
  
  render: ->
    @$el.html(@template(@model.toTemplate()))
    @
    
  deletePhoto: ->
    console.log "deleting", @model
    el = @$el
    @model.destroy
      success: (model, response) ->
        unless response.error
          el.remove()
          
  changeDescription: (event) ->
    current_description = $(event.target).val()
    if @model.get('description') != current_description
      @model.save { 'description': current_description }, { patch: true }
