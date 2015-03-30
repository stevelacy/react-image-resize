React = require 'react'

DOM = React.DOM

module.exports = React.createClass
  componentWillMount: ->

    resizeImage = (opts) ->

      image = new Image()

      image.onload = ->
        canvas = opts.el

        h = opts.scale*image.height/image.width

        canvas.width = opts.scale
        canvas.height = h
        ctx = canvas.getContext '2d'
        ctx.drawImage image, 0, 0, opts.scale, h

      image.src = opts.src

    resizeImage
      src: '500.jpg'
      scale: 600
      el: document.getElementById 'canvas'

  render: ->

    DOM.div
      className: 'box'
    ,
      DOM.img
        src: '500.jpg'
