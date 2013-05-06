class Jourmie.Views.Albums.PhotosManager extends Backbone.View
  
  template: JST['albums/photos_manager']
  model: 'Jourmie.Models.Place'
  
#  events:
  
  render: ->
    @$el.html(@template(@model.toTemplate()))
    for photo in @model.get('photos').models
      photo_view = new Jourmie.Views.Albums.PhotoItem({ model: photo })
      @$el.find("#photos").append(photo_view.render().$el)
    place_model = @model
    $el = @$el

    $.get 's3_upload_form', (response) ->
      $el.find('.folder-area').html(response)
      $uploadForm = $el.find("form.direct-upload")
      $uploadForm.fileupload
        add: (e, data) ->
          file = data.files[0]
          file.unique_id = Math.random().toString(36).substr(2,16)
          
          photo = new Jourmie.Models.Photo()
          photo_view = new Jourmie.Views.Albums.PhotoItem({ model: photo })
          photo_view_el = photo_view.render().$el
          data.context = { model: photo, view: photo_view_el }
          $('#photos').append(data.context.view)
          data.submit()
        done: (e, data) ->
          content = build_content_object $uploadForm, data.files[0], data.result
          console.log content
          if data.context
            Window.place_model = place_model
            console.log "Add photo to place", place_model
            data.context.model.set 'thumb', content.url
            console.log content, content.url, data.context.model
            place_model.get('photos').add data.context.model
            data.context.model.save({ remote_file_url: data.context.model.get('file') })
        progress: (e, data) ->
          if data.context
            progress = parseInt(data.loaded/data.total * 100, 10)
            data.context.view.find('.bar').css('width', progress + '%')
        formData: (form) ->
          data = form.serializeArray()
          fileType = ""
          if "type" of @files[0]
            fileType = @files[0].type
          data.push
            name: "content-type"
            value: fileType
          # substitute upload timestamp and unique_id into key
          key = data[1].value.replace('{timestamp}', new Date().getTime()).replace('{unique_id}', @files[0].unique_id)
          data[1].value =  key
          data
    @
   
  build_content_object = ($uploadForm, file, result) ->
    content = {}
    if result # Use the S3 response to set the URL to avoid character encodings bugs
      content.url      = $(result).find("Location").text()
      content.filepath = $('<a />').attr('href', content.url)[0].pathname
    else # IE <= 9 return a null result object so we use the file object instead
      domain           = $uploadForm.attr('action')
      content.filepath = $uploadForm.find('input[name=key]').val().replace('/${filename}', '')
      content.url      = domain + content.filepath + '/' + encodeURIComponent(file.name)

    content.filename   = file.name
    content.filesize   = file.size if 'size' of file
    content.filetype   = file.type if 'type' of file
    content.unique_id  = file.unique_id if 'unique_id' of file
    content.relativePath = build_relativePath(file) if has_relativePath(file)
    content

  has_relativePath = (file) ->
    file.relativePath || file.webkitRelativePath

  build_relativePath = (file) ->
    file.relativePath || (file.webkitRelativePath.split("/")[0..-2].join("/") + "/" if file.webkitRelativePath)
