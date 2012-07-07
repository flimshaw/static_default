@app = window.app ? {}

jQuery ->
        app.Projects.fetch()
        app.router = new app.appRounter()
        app.router.on "route", () ->
                console.log "routed."
        Backbone.history.start()
        console.log "Backbone loaded."