# Helpers!
@app = window.app ? {}

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