@app = window.app ? {}

describe "Default", () ->
        beforeEach () ->

                runs () ->
                        app.Default.fetch()

                waitsFor () ->
                        app.Default.length == 3

                runs () ->
                        @Default = app.Default

        it "loads properly from the json file", ->
                expect(@Default.models[0].get('title') == "Project 1").toBeTruthy()

        it "can be searched for Default by a particular director", ->
                expect(@Default.byDirector('Director 1').length).toBe(2)
                expect(@Default.byDirector('Director 1').models[0].get('video').director).toBe('Director 1')
                expect(@Default.byDirector('Director 1').models[1].get('video').director).toBe('Director 1')

        it "can return a list of unique directors", ->
                @directors = @Default.listDirectors()
                expect(@directors.length).toBe(2)
                expect(@directors[0]).toBe("Director 1")
                expect(@directors[1]).not.toBe("Director 2")