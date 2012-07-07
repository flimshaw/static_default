# COLLECTIONS
@app = window.app ? {}

class Projects extends Backbone.Collection
        model: app.Project
        url: '/projects'

        byDirector: (director) ->
                dirProjects = @.filter (project) ->
                        project.get('video').director == director
                @.reset(dirProjects)

        listDirectors: () ->
                @directors = []
                @.each (project) =>
                        @directors.push(project.get('video').director)
                _.uniq(@directors)

# Give our app an instance of Projects right away
@app.Projects = new Projects
