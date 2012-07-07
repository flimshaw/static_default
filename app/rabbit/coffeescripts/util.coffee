# Helpers!
@app = window.app ? {}

setNav = (id) ->
        $("header nav .onState").removeClass("onState")
        $(id).addClass("onState")

class Buffer
        commands: []

        add: (fn) =>
                
                next = () =>
                        @commands.shift()
                        if @commands.length
                                @commands[0](next)

                @commands.push(fn)
                if @commands.length == 1
                        fn(next)

                @commands.length
                        
# this will "extend" Backbone.Events, which isn't actually a class apparently (see http://stackoverflow.com/questions/11068059/cant-extend-backbone-events-in-coffeescript)
class ViewContainer

        # type of animation we'll use, default to bounce out left for no reason at all
        animateOutType: "bounceOutLeft"
        animateInType: "bounceInLeft"

        # pass the loader the div it should inject content into
        constructor: (targetDiv) ->
                @contentBuffer = new Buffer()
                _.extend @, Backbone.Events
                @$targetDiv = targetDiv
                @$targetDiv.addClass('animated')

        run: (fn) ->
                @contentBuffer.add (fn)

        bufferLength: () ->
                @contentBuffer.commands.length

        animate: (callback) =>
                @callback = callback
                @$targetDiv.addClass(@animateOutType)
                @$targetDiv.bind 'webkitAnimationEnd', (e) =>
                        @$targetDiv.empty()
                        @$targetDiv.unbind 'webkitAnimationEnd'
                        @$targetDiv.html(@newView.render())
                        @$targetDiv.removeClass(@animateOutType)
                        @$targetDiv.addClass(@animateInType)
                        @$targetDiv.bind 'webkitAnimationEnd', @callback

        load: (view) ->
                @newView = view
                fn = (next) =>
                        @animate(next)
                @run(fn)



@app.ViewContainer = ViewContainer
@app.setNav = setNav