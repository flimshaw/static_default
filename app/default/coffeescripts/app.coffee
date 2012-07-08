@app = window.app ? {}

jQuery ->
        app.Albums.fetch()
        app.router = new app.AppRouter()
        app.router.on "route", () ->
                console.log "routed."
        Backbone.history.start()
        console.log "Backbone loaded."