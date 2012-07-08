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

          app.AppRouter = AppRouter
                        
                