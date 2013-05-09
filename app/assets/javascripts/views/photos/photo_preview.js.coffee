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
    @setSizes()
    @
  
  setSizes: ->
    window_width = $(window).width()
    info_width = @$el.find('.info').outerWidth()
    preview_width = window_width-100
    @$el.css('width', preview_width + 'px')
    @$el.find('.image').css('width', (preview_width - info_width) + 'px')
    @$el.find('.image img').css
      'max-width': (preview_width-info_width) + 'px'
      'width': (preview_width-info_width) + 'px'
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
