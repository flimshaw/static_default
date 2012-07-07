# VIEWS
@app = window.app ? {}

jQuery ->

        # view for individual projects
        class DefaultView extends Backbone.View

                tagName: 'li'

                initialize: () ->
                        @template = _.template($("#default_template").html())
                        @model.bind 'change', @render, @

                render: () ->
                        renderedContent = @template(@model.toJSON())
                        $(@el).html(renderedContent)
                        @

        # view to display all projects
        class DefaultsView extends Backbone.View

                tagName: 'div'
                className: 'defaults'

                initialize: () ->
                        @template = _.template($('#defaults_template').html())
                        @collection.bind 'reset', @render, @

                render: () ->
                        $(@el).html(@template({}))
                        @collection.each (project) =>
                                view = new ProjectView
                                        model: project
                                        collection: @collection
                                $projects.append(view.render().el)
                        @

        # export views so other modules can get at them
        app.DefaultView = DefaultView
        app.DefaultsView = DefaultsView        