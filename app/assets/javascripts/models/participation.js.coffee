class Jourmie.Models.Participation extends Backbone.RelationalModel
  url: ->
    if @get('album').get('id') isnt undefined && @get('id') is undefined
      "/albums/#{@get('album').get('id')}/participations"
    else if @get('album').get('id') isnt undefined && @get('id') isnt undefined
      "/albums/#{@get('album').get('id')}/participations/#{@get('id')}"

Jourmie.Models.Participation.setup()
