class Jourmie.Models.Participation extends Backbone.RelationalModel
  url: -> 
    if @get('album').get('id')
      "/albums/#{@get('album').get('id')}/participations"
      
Jourmie.Models.Participation.setup()
