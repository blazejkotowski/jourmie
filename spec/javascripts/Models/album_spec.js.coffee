#/ require javascripts/models/album

describe "Album", ->

	it "Creates an Untitled Album when no name is given", ->
		album = new Jourmie.Models.Album()
		expect(album.get('name')).toBe("Untitled")

	it "Should create an Album Model with the correct name", ->
		album = new Jourmie.Models.Album(name: "Test")
		expect(album.get("name")).toEqual("Test")

	it "Should make cover1 has default cover image", -> 
		album = new Jourmie.Models.Album(name: 'Test')
		expect(album.get('name')).toBe("Test")
		expect(album.get('cover_image')).toBe('/assets/covers/cover1.jpg')
	
	it "Should have many places", ->
		album = new Jourmie.Models.Album()
		expect(album.get('places')).toBeDefined()

	it "Should have many participations", ->
		album = new Jourmie.Models.Album()
		expect(album.get('participations')).toBeDefined()		

	it "Should create an Album Model with current Date for start date", ->
		album = new Jourmie.Models.Album()
		date = new Date()
		expect(album.get('start_date')).toEqual(date)

	it "Should create an Album Model with current Date + 14 days for end date", ->
		album = new Jourmie.Models.Album()
		date = new Date()
		date.setDate(date.getDate() + 14)
		expect(album.get('end_date')).toEqual(date)

	it "Should not allow creating an Album with end_date before start_date", ->
		date = new Date()
		date2 = new Date()
		date2.setDate(date2.getDate()-1)
		album = new Jourmie.Models.Album(start_date: date,end_date: date2)
		expect(album.get('end_date')).not.toBeDefined()

	it "Should increment places by 1 when new place is added", ->
		date = new Date()
		place = new Jourmie.Models.Place(atitude: 1.0,
      		longitude: 1.0,
      		name: "test",
      		date_from: date,
      		date_to: date)
		album = new Jourmie.Models.Album(name: "test")
		expect(album.get('places').length).toEqual(0)
		album.addPlace(place)
		expect(album.get('places').length).toEqual(1)

	it "should make an AJAX request to the correct URL for getting an album", ->
		spyOn($, "ajax")
		album = new Jourmie.Models.Album(id: 1)
		album.fetch()
		expect($.ajax.mostRecentCall.args[0]["url"]).toEqual("/albums/1.json")

	it "should make an AJAX request to the correct URL for saving an album", ->
		spyOn($, "ajax")
		album = new Jourmie.Models.Album(name: "test")
		album.save()
		expect($.ajax.mostRecentCall.args[0]["url"]).toEqual("/albums.json")




