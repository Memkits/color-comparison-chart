
var
  deku $ require :deku
  Color $ require :color

var
  div $ deku.element.bind null :div
  textarea $ deku.element.bind null :textarea

var showHex $ \ (text)
  try
    do
      var colorObj $ Color text
      return $ colorObj.hexString
    error
      return :error

var showHsl $ \ (text)
  try
    do
      var colorObj $ Color text
      return $ colorObj.hslString
    error
      return :error

var showRgb $ \ (text)
  try
    do
      var colorObj $ Color text
      return $ colorObj.rgbString
    error
      return :error

= module.exports $ {}
  :initialState $ \ ()
    return $ {}
      :text :
      :colors $ []

  :afterMount $ \ (component el setState)
    var text $ localStorage.getItem :hex-color-list
    setState $ {}
      :text text

  :afterUpdate $ \ (component prevProps prevState setState)
    localStorage.setItem :hex-color-list component.state.text

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
      textarea ({} (:value state.text) (:onInput onChange) (:class :text))
      div ({} (:class :colors))
        colors.map $ \ (color)
          return $ div ({}) (showHex color)
      div ({} (:class :colors))
        colors.map $ \ (color)
          return $ div ({}) (showHsl color)
      div ({} (:class :colors))
        colors.map $ \ (color)
          return $ div ({}) (showRgb color)
      div ({} (:class :demos))
        colors.map $ \ (color)
          return $ div
            {}
              :class :color-demo
              :style $ {}
                :background-color (showHsl color)
