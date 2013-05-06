class Jourmie.Models.Album extends Backbone.RelationalModel
  
  url: -> 
    if @get('id')
      "/albums/#{@get('id')}.json"
    else
      "/albums.json"
  
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
    },
    {
      key: 'participations'
      type: Backbone.HasMany
      relatedModel: 'Jourmie.Models.Participation'
      collectionType: 'Jourmie.Collections.Participations'
      includeInJSON: false
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
    @setNewDates()
    
    console.log "New backbone album"
    
  setNewDates: ->
    start_date = new Date()
    end_date = new Date()
    end_date.setDate(end_date.getDate() + 14)
    @set
      start_date_string: "#{('0'+start_date.getDate()).substr(-2)}-#{('0'+(start_date.getMonth()+1)).substr(-2)}-#{start_date.getFullYear()}"
      end_date_string: "#{('0'+end_date.getDate()).substr(-2)}-#{('0'+(end_date.getMonth()+1)).substr(-2)}-#{end_date.getFullYear()}"
  
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
  
  toTemplate: ->
    _.clone(@attributes)
  
Jourmie.Models.Album.setup()
