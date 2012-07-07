# MODELS
@app = window.app ? {}


class Model extends Backbone.Model

# Tie projects into global app var
@app.Model = Model
