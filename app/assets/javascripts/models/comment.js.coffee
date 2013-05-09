class Jourmie.Models.Comment extends Backbone.RelationalModel
  
  url: ->
    if(@get('commentable_id'))
      "/content_pieces/#{@get('commentable_id')}/comments"

Jourmie.Models.Comment.setup()

