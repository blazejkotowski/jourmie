class Jourmie.Models.Album extends Backbone.RelationalModel
  
  url: -> "/albums/#{@get('id')}.json"
  
  defaults:
    cover_image: '/assets/covers/cover1.jpg'

  relations: [
    {
      key: 'places'
      type: Backbone.HasMany
      relatedModel: 'Jourmie.Models.Place'
      reverseRelation:
        key: 'album'
        type: Backbone.HasOne
    },
    { 
      key: 'roads'
      type: Backbone.HasMany
      relatedModel: 'Jourmie.Models.Road'
      reverseRelation:
        key: 'album'
        type: Backbone.HasOne
    }
  ]
  
  initialize: ->
    console.log @get('cover_file')
    if @get('cover_file') is undefined
      @set('cover_file', '/assets/covers/cover1.jpg')
    
    @set('available_covers', [])
    i=1
    while(i <= 20)
      @get('available_covers').push "/assets/covers/cover#{i++}.jpg"
      
    console.log "New backbone album"
    
  addPlace: (place) ->
    new_road = null
    @get('places').add place
    if @get('places').length > 1
      from = @get('places').at(@get('places').length-2)
      to = @get('places').at(@get('places').length-1)
      new_road = new Jourmie.Models.Road
        place_from: from
        place_to: to
      @get('roads').add new_road
    new_road
  
Jourmie.Models.Album.setup()
