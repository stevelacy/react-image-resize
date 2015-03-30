React = require 'react'

DOM = React.DOM

module.exports = React.createClass
  componentWillMount: ->

    resizeImage = (opts, cb) ->

      image = new Image()
      image.setAttribute 'crossOrigin', 'anonymous'

      image.onload = ->
        canvas = opts.el

        h = opts.scale*image.height/image.width

        canvas.width = opts.scale
        canvas.height = h
        ctx = canvas.getContext '2d'
        ctx.drawImage image, 0, 0, canvas.width, canvas.height
        return cb null, canvas.toDataURL()

      image.src = opts.src
      image.onerror = cb

    resizeImage
      src: '500.jpg'
      scale: 600
      el: document.createElement 'canvas'
    , (err, data) =>
      @refs.image.getDOMNode().src = data

  render: ->

    DOM.div
      className: 'box'
    ,
      DOM.img
        ref: 'image'
        src: '500.jpg'
