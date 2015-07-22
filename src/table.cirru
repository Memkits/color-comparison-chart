
var
  deku $ require :deku
  Color $ require :color

var
  div $ deku.element.bind null :div
  textarea $ deku.element.bind null :textarea

var toFormat $ \ (text method)
  try
    do
      var colorObj $ Color text
      return $ method colorObj
    error
      return :__err__

var showHex $ \ (text)
  return $ toFormat text $ \ (colorObj)
    return $ colorObj.hexString

var showHsl $ \ (text)
  return $ toFormat text $ \ (colorObj)
    return $ colorObj.hslString

var showRgb $ \ (text)
  return $ toFormat text $ \ (colorObj)
    return $ colorObj.rgbString

= module.exports $ {}
  :initialState $ \ ()
    return $ {}
      :text :
      :colors $ []

  :afterMount $ \ (component el setState)
    var text $ localStorage.getItem :color-comparison-chart
    setState $ {}
      :text $ or text ":hsl(240,100%,90%)"

  :afterUpdate $ \ (component prevProps prevState setState)
    localStorage.setItem :color-comparison-chart component.state.text

  :render $ \ (component setState)
    var state component.state

    var onChange $ \ (event)
      var newState $ {}
        :text event.target.value
      setState newState

    var colors $ ... state.text
      trim
      split ":\n"

    return $ div ({} (:class :app-table))
      textarea $ {} (:value state.text) (:onInput onChange)
        :class :text
        :autofocus true
      div ({} (:class :collection))
        colors.map $ \ (color)
          return $ div ({} (:class :colors))
            div ({}) (showHex color)
            div ({}) (showHsl color)
            div ({}) (showRgb color)
            div $ {}
              :class :color-demo
              :style $ {}
                :background-color (showHsl color)
