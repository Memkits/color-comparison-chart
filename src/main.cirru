
var
  deku $ require :deku

var
  div $ deku.element.bind null :div
  Table $ deku.element.bind null $ require :./table

var pageComponent $ deku.element $ {}
  :render $ \ (component setState)
    return $ div ({} (:class :app-page))
      Table

var Page $ deku.tree pageComponent

deku.render Page (document.querySelector :#app)
