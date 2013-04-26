class Jourmie.Models.Album extends Backbone.RelationalModel
  
  url: -> "/albums/#{@get('id')}.json"
  
  defaults:
    cover_image: '/assets/covers/cover1.jpg'
  
  relations: [
    {
      key: 'places'
      type: Backbone.HasMany
      relatedModel: 'Jourmie.Models.Place'
      collectionType: 'Jourmie.Collections.Places'
      reverseRelation:
        key: 'album'
        keySource: 'album_id'
        includeInJSON: 'id'
        type: Backbone.HasOne
    }
  ]
  
  initialize: ->
    @set('available_covers', [])
    i=1
    while(i <= 20)
      @get('available_covers')[i] = "/assets/covers/cover#{i++}.jpg"
      
    console.log "New backbone album"
    
  addPlace: (place) ->
    new_road = from = to = null
    @get('places').add place
    to = @get('places').at(@get('places').length-1)
    if @get('places').length > 1
      from = @get('places').at(@get('places').length-2)
      new_road = new Jourmie.Models.Road
        place_from: from
        place_to: to
      @get('roads').add new_road
      console.log "road", new_road

    to.save {},
      success: -> 
        if new_road isnt null
          new_road.save {},
            success: ->
              if from isnt null
                from.save
          
      
    new_road
  
Jourmie.Models.Album.setup()
