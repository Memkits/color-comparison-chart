
var
  deku $ require :deku
  Color $ require :color

var
  div $ deku.element.bind null :div
  textarea $ deku.element.bind null :textarea

var parseColors $ \ (text)
  var lines $ ... text
    trim
    split ":\n"
  return $ lines.map $ \ (color)
    try
      do
        var colorObj $ Color color
        return $ colorObj.hslString
      error
        console.log error
        return :red

= module.exports $ {}
  :initialState $ \ ()
    return $ {}
      :text :
      :colors $ []

  :afterMount $ \ (component el setState)
    var text $ localStorage.getItem :hex-color-list
    setState $ {}
      :text text
      :colors $ parseColors text

  :afterUpdate $ \ (component prevProps prevState setState)
    localStorage.setItem :hex-color-list component.state.text

  :render $ \ (component setState)
    var state component.state

    var onChange $ \ (event)
      var newState $ {}
        :text event.target.value
        :colors $ parseColors event.target.value
      setState newState

    return $ div ({} (:class :app-table))
      textarea ({} (:value state.text) (:onInput onChange) (:class :text))
      div ({} (:class :colors))
        state.colors.map $ \ (color)
          return $ div ({}) color
      div ({} (:class :demos))
        state.colors.map $ \ (color)
          return $ div
            {}
              :class :color-demo
              :style $ {}
                :background-color color
            , ":demo"
