# VIEWS
@app = window.app ? {}

jQuery ->

        class NavView extends Backbone.View

                initialize: () ->
                        @template = _.template($("#nav_template").html())

                render: () ->
                        renderedContent = @template()
                        $(@el).html(renderedContent)
                        @

        # test view with known content for testing
        class TestView extends Backbone.View

                initialize: () ->
                        @template = _.template($("#test_template").html())

                render: () ->
                        renderedContent = @template()
                        $(@el).html(renderedContent)


        # view for individual projects
        class ProjectView extends Backbone.View

                tagName: 'li'

                initialize: () ->
                        @template = _.template($("#project_template").html())
                        @model.bind 'change', @render, @

                render: () ->
                        renderedContent = @template(@model.toJSON())
                        $(@el).html(renderedContent)
                        @

        # view to display all projects
        class ProjectsView extends Backbone.View

                tagName: 'div'
                className: 'projects'

                initialize: () ->
                        @template = _.template($('#projects_template').html())
                        @collection.bind 'reset', @render, @

                render: () ->
                        $(@el).html(@template({}))
                        $projects = @.$('.projects')
                        @collection.each (project) =>
                                view = new ProjectView
                                        model: project
                                        collection: @collection
                                $projects.append(view.render().el)
                        @

        # view to display one director's projects
        class DirectorProjectsView extends ProjectsView

        # view for individual director name listings
        class DirectorView extends ProjectView

                initialize: () ->
                        @template = _.template($("#director_template").html());
                
        # view to display a list of directors
        class DirectorListView extends Backbone.View

                tagName: 'section'
                className: 'directors'

                initialize: () ->
                        @template = _.template($('#directorList_template').html())
                        @collection.bind 'reset', @render, @

                render: () ->
                        $(@el).html(@template({}))
                        $directorList = @.$('.directors')
                        _.each @collection.listDirectors(), (director) =>
                                model = new Backbone.Model({ director: director })
                                view = new DirectorView
                                        model: model
                                        collection: @collection
                                $directorList.append(view.render().el)
                        @
                        

        # export views so other modules can get at them
        app.TestView = TestView
        app.ProjectsView = ProjectsView
        app.ProjectView = ProjectView
        app.DirectorView = DirectorView
        app.DirectorListView = DirectorListView
        app.NavView = NavView        