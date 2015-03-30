# core
gulp = require 'gulp'

# stream utilities
path = require 'path'

# plugins
reload = require 'gulp-livereload'
stylus = require 'gulp-stylus'
# misc
autowatch = require 'gulp-autowatch'

# browserify crap
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
coffeeify = require 'coffeeify'
browserify = require 'browserify'
watchify = require 'watchify'

# paths
paths =
  bundle: './src/index.coffee'
  stylus: './src/index.styl'

# javascript
args =
  fullPaths: true
  debug: true
  cache: {}
  packageCache: {}
  extensions: ['.coffee']

bundler = browserify paths.bundle, args
bundler = watchify bundler
bundler.transform coffeeify


bundle = ->
  bundler.bundle()
    .pipe source 'index.js'
    .pipe buffer()
    .pipe gulp.dest './public'
    .pipe reload()

gulp.task 'js', bundle

gulp.task 'stylus', ->
  gulp.src paths.stylus
    .pipe stylus()
    .pipe gulp.dest './public'
    .pipe reload()

gulp.task 'watch', (cb) ->
  reload.listen()
  bundler.on 'update', gulp.parallel 'js'
  autowatch gulp, paths
  cb()

gulp.task 'default', gulp.series 'watch', 'js'
