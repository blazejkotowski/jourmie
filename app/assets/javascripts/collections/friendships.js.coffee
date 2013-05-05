class Jourmie.Collections.Friendships extends Backbone.Collection
  url: -> "/profiles/#{@profile_id}/friendships"
#  model: Jourmie.Models.Friendship
  
  initialize: (profile_id) ->
    @profile_id = profile_id
