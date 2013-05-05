class Jourmie.UserProfiles
  
  initialize: ->
    jQuery -> 
      $("a.add-friend").on "click", (e) ->
        e.preventDefault()
        $.post $(e.target).attr("href"), {}, (data) ->
          if data.message
            Helpers.prettyAlert(data.message)
          else if data.error
            Helpers.prettyAlert(data.error)
            
      $('.profile-header .buttons a').on "click", (e) ->
        e.preventDefault()
        url = $(e.target).closest('a').attr('href')
        $('.profile-body').load(url)
        
