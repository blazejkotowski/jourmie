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
        
class Jourmie.UsersAutocomplete
  
  initialize: ->
    jQuery ->
      autocomplete = $("#jourmie_search").autocomplete
        source: "/profiles/autocomplete"
        minLength: 3
        messages:
          noResults: ''
          results: -> undefined
      autocomplete.data("ui-autocomplete")._renderItem = (ul, item) ->
        $item = $("<li/>").addClass('search-users-item')
                  .append("<a href=\"#{Helpers.showProfileUrl(item.permalink)}\"><img src=\"#{item.avatar}\" />#{item.display_name}</a>")
        ul.append($item)
      autocomplete.autocomplete("widget").addClass("search-users")

