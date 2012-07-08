# VIEWS
@app = window.app ? {}

# view for individual projects
class AlbumView extends Backbone.View

        tagName: 'li'

        initialize: () ->
                @template = _.template($("#album_template").html())
                @model.bind 'change', @render, @

        render: () ->
                renderedContent = @template(@model.toJSON())
                $(@el).html(renderedContent)
                @
                
# view to display all projects
class AlbumsView extends Backbone.View

        tagName: 'div'
        className: 'albums'

        initialize: () ->
                @template = _.template($('#albums_template').html())
                @collection.bind 'reset', @render, @

        render: () ->
                $(@el).html(@template({}))
                $albums = @.$('.albums')
                @collection.each (album) =>
                        view = new AlbumView
                                model: album
                                collection: @collection
                        $albums.append(view.render().el)
                @
                
@app.AlbumView = AlbumView
@app.AlbumsView = AlbumsView