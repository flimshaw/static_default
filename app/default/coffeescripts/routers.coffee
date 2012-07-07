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
                        @view = new app.ProjectsView collection: app.Projects
                        @$container.html(@view.render().el)
                        app.setNav('')

          app.AppRouter = AppRouter