class Jourmie.Views.Albums.ShowRoad extends Backbone.View

  template: JST['albums/show_road']
  model: 'Jourmie.Models.Road'
  className: 'show-road'

  render: ->
    @$el.html(@template(@model.toTemplate()))
    @

  renderContent: ->
    contentView = new Jourmie.Views.Albums.ShowPhotos({ collection: @model.get('photos') })
    @$el.find('.road-content').html(contentView.render().$el)

