pxt = (args...) ->
  f = pxt.font
  f.render args...
module.exports = pxt

unifont = require './unifont'

pxt.font_type = 'pixel'
pxt.font = unifont

pxt.init = (fn_loaded_callback) ->
  f = pxt.font
  f.init fn_loaded_callback

pxt.font_info = ->
  f = pxt.font
  info =
    char_h: f.char_h
    
  info

# todo... get rid of this
if window?
  window.pxt = pxt