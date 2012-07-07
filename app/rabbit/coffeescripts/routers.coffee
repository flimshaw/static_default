# ROUTERS
@app = window.app ? {}

jQuery ->

        class ProjectsRouter extends Backbone.Router

                routes:
                        '': 'home'
                        'blank': 'blank'
                        'directors': 'directors'
                        'director/:directorName': 'director'
                        'animation': 'animation'
                        'entertainment': 'entertainment'
                        'about': 'about'

                initialize: () ->
                        @$container = $('#container')
                        @nav = new app.NavView()
                        $("header nav").html(@nav.render().el)

                home: () ->
                        @$container.empty()
                        @view = new app.ProjectsView collection: app.Projects
                        @$container.html(@view.render().el)
                        app.setNav('')

                directors: () ->
                        @directorListView = new app.DirectorListView collection: app.Projects
                        @$container.empty()
                        @$container.append(@directorListView.render().el)
                        app.setNav('#directors')

                director: (directorName) ->
                        @$container.empty()
                        @$container.append(directorName)
                        app.setNav('#directors')

                animation: () ->
                        @$container.empty()
                        @$container.text('animation!')
                        app.setNav('#animation')

                entertainment: () ->
                        @$container.empty()
                        @$container.text('entertainment!')
                        app.setNav('#entertainment')

                about: () ->
                        @$container.empty()
                        @$container.text('about!')
                        app.setNav('#about')
                        

          app.ProjectsRouter = ProjectsRouter