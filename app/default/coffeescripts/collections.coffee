# COLLECTIONS
@app = window.app ? {}

class Albums extends Backbone.Collection
        model: app.Album
        url: '/albums'
        
@app.Albums = new Albums()