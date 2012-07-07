# COLLECTIONS
@app = window.app ? {}

class Defaults extends Backbone.Collection
        model: app.Project
        url: '/defaults'

# Give our app an instance of Projects right away
@app.Defaults = new Defaults
