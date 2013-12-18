pxt, a pixel text renderer
--------------------------

this just draws gnu unifont into a canvas context right now,
but i wanna add other pixel fonts.

### requirements for building

browserify
coffeescript
stylus

### api

    pxt.init([fn])
loads font data, `fn` is an optional callback that is called when the font is loaded

    pxt(ctx, s, [opts])
draws the text string `s` into 2d context `ctx`
