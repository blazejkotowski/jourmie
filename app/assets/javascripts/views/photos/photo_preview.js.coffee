class Jourmie.Views.Photos.PhotoPreview extends Backbone.View
  
  model: 'Jourmie.Models.Photo'
  tagName: 'div'
  className: 'photo-preview'
  template: JST['photos/photo_preview']

  events:
    'click .jr-close': 'closePreview'
    'submit #new-comment-form': 'newComment'

  initialize: ->
    _.bindAll(this, 'render')
    @model.on 'change', @render

  render: ->
    @$el.html(@template(@model.toJSON()))
    @

  closePreview: (e) ->
    e.preventDefault()
    Helpers.hideLightShutter()
    Helpers.setLightShutterBody('')

  newComment: (event) ->
    event.preventDefault()
    comment = new Jourmie.Models.Comment
      content: $("#comment-content").val()
      commentable_id: @model.get('id')
    
    Window.comment = comment
    $("#comment-content").attr("disabled", true)
    current_model = @model
    comment.save {},
      success: ->
        $("#comment-content").val('').removeAttr("disabled")
        current_model.get('comments').add comment
        current_model.trigger('change')
