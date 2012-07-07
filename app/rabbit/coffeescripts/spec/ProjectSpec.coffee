@app = window.app ? {}

describe "Navigation", () ->

        beforeEach () ->
                @view = new app.NavView()

        it "loads a view containing our nav items", () ->
                expect(@view.render().$el.html()).toMatch(/Directors/)

        it "updates its state when you click on a link", () ->
                runs () ->
                        app.router.navigate("/#/entertainment")

                waits(10)

                runs () ->
                        expect($("nav a#entertainment").hasClass("onState")).toBe(true)


describe "Projects", () ->
        beforeEach () ->

                runs () ->
                        app.Projects.fetch()

                waitsFor () ->
                        app.Projects.length == 3

                runs () ->
                        @projects = app.Projects

        it "loads properly from the json file", ->
                expect(@projects.models[0].get('title') == "Project 1").toBeTruthy()

        it "can be searched for projects by a particular director", ->
                expect(@projects.byDirector('Director 1').length).toBe(2)
                expect(@projects.byDirector('Director 1').models[0].get('video').director).toBe('Director 1')
                expect(@projects.byDirector('Director 1').models[1].get('video').director).toBe('Director 1')

        it "can return a list of unique directors", ->
                @directors = @projects.listDirectors()
                expect(@directors.length).toBe(2)
                expect(@directors[0]).toBe("Director 1")
                expect(@directors[1]).not.toBe("Director 2")


describe "ProjectView", () ->
        beforeEach () ->
                waitsFor () ->
                        app.Projects.length > 0
                runs () ->
                        @project = app.Projects.models[0]

        it "should load the right project from the collection", () ->
                expect(@project.get('title') == "Project 1").toBe(true);

        it "should properly populate a template with that project", () ->
                @projectView = new app.ProjectView model: @project
                expect(@projectView.render().$el.html()).toMatch(/Director 1/);

describe "ProjectsView", () ->
        beforeEach () ->
                waitsFor () ->
                        app.Projects.length > 0

        it "should load 3 projects from our json store", () ->
                expect(app.Projects.length == 3).toBe(true)

        it "should populate the template with the collection data", () ->
                @projectsView = new app.ProjectsView collection: app.Projects
                expect(@projectsView.render().$el.html()).toMatch(/Director 3/)
                
describe "ViewContainer", () ->

        beforeEach () ->
                @testTemplate = $("#test_template").html()
                @$viewContainer = $("#viewContainer")
                @viewContainer = new app.ViewContainer(@$viewContainer)

        describe "Buffer", () ->
        
                it "should be able to return how many items are waiting in the queue", () ->
                        expect(@viewContainer.bufferLength()).not.toBe(null)

                it "should execute new functions to be added to its buffer", () ->
                        app.testVar = false
                        @viewContainer.run (next) ->
                                app.testVar = true
                                setTimeout(next, 10)
                                @

                        expect(@viewContainer.bufferLength() > 0).toBe(true)
                        waits(20)
                        expect(app.testVar).toBe(true)

                it "should execute all functions sent to it", () ->
                        app.testVar = 0
                        testFun = (next) ->
                                app.testVar++
                                next()
                        @viewContainer.run(testFun) for i in [1..10]
                        waits(50)
                        expect(app.testVar).toBe(10)


        it "should return its animation type with public values", () ->
                expect(@viewContainer.animateOutType).toBe("bounceOutLeft")