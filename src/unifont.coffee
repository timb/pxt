unifont = {}
module.exports = unifont

dom = {}

sheet = null

sheet_w_in_chars = 256
char_w_full = 16
char_w_half = 8
char_h = unifont.char_h = 16
sheet_pad_left_in_chars = 2
sheet_pad_top_in_chars = 4
sheet_pad_left = sheet_pad_left_in_chars * char_w_full
sheet_pad_top = sheet_pad_top_in_chars * char_h

char_linefeed = 0x0a

# url_sheet = './img/gnu_unifont-6.3.20131020.png'
url_sheet = 'http://i.imgur.com/kiVf8Hm.png'

# some chars are half width
# todo, complete this
char_w = unifont.char_w = (char_code) ->
  w = char_w_full
  h = char_w_half
  if char_code <= 0x1f
    return w
  if char_code <= 0x7e
    return h
  if char_code <= 0x9f
    return w
  if char_code <= 0xac
    return h
  if char_code == 0xad
    return w
  if char_code <= 0x034e
    return h
  if char_code > 65535
    console.log("too large")
  w

sheet_loaded = ->
  # console.log sheet

unifont.init = (fn_loaded_callback) ->
  
  fn_loaded = ->
    sheet_loaded()
    if fn_loaded_callback
      fn_loaded_callback()

  sheet = new Image()
  sheet.crossOrigin = 'anonymous'
  sheet.addEventListener "load", fn_loaded
  sheet.src = url_sheet

unifont.cursor_calculate_pos = (input, selection) ->
  chars = input.split ''
  x = 0
  y = 0
  for i in [0...selection.start]
    char_value = chars[i].charCodeAt(0)
    if char_value == char_linefeed
      x = 0
      y += char_h
      continue
    w = char_w(char_value)
    x += w   
  [x, y]

unifont.bounds_calc = (input, x, y) ->


unifont.render = (ctx, input, x, y) ->
  chars = input.split ''
  # console.log(chars)
  x = x || 0
  y = y || 0

  # ctx.clearRect 0,0, ctx.canvas.width,ctx.canvas.height

  for i in [0...chars.length]

    char_value = chars[i].charCodeAt(0)

    if char_value == char_linefeed
      x = 0
      y += char_h
      continue

    w = char_w(char_value)
    #console.log( w)
    #console.log(char_value)
    unifont.draw_char_on_canvas(char_value, ctx, x, y, w, char_h)
    x += w

  0
  

unifont.draw_char_on_canvas = (char_value, ctx, ctx_x, ctx_y, w, h)->
  sheet_x = (char_value % sheet_w_in_chars) * char_w_full
  sheet_x += sheet_pad_left
  sheet_y = ((char_value / sheet_w_in_chars) |0) * char_h
  sheet_y += sheet_pad_top

  # console.log (char_value % sheet_w_in_chars), sheet_x, sheet_y, w, h, ctx_x, ctx_y, w, h
  ctx.drawImage(sheet, 
                sheet_x|0, sheet_y|0, w, h,
                ctx_x|0, ctx_y|0, w, h)
  0

