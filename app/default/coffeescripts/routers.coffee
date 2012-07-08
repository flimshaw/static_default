# ROUTERS
@app = window.app ? {}

jQuery ->

        class AppRouter extends Backbone.Router

                routes:
                        '': 'home'
                        'blank': 'blank'
  
                initialize: () ->
                        @$container = $('#container')

                home: () ->
                        @$container.empty()
                        @view = new app.AlbumsView collection: app.Albums
                        @$container.html(@view.render().el)

          app.AppRouter = AppRouter