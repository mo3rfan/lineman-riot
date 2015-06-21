module.exports = (lineman) ->
  app = lineman.config.application
  lmfiles = lineman.config.files
  app.lm_riot = new Object
  app.lm_riot.modular = "notset"

  files:
    riotjade:
      app: "app/riottags/**/*.jade"
    riot:
      app: "app/riottags/**/*.tag"
      generated: "app/js/riottags/riot.tags.js"
  config:
    loadNpmTasks: app.loadNpmTasks.concat "grunt-riot"

    prependTasks:
      common: app.prependTasks.common.concat ["riot"]

    concat_sourcemap:
      js:
        src:
          app.concat_sourcemap.js.src
            .concat "<%= files.riot.generated %>"
    
    riot:
      compile:
        options:
          concat: true
          modular:
            if app.lm_riot.modular != "notset"
              type: app.lm_riot.modular
            else if app.browserify
              type: 'common'
            else if app.requirejs
              type: 'amd'
            else
              false
        files:
          if lmfiles.jade
            "<%= files.riot.generated %>": "<%= files.riot.app %>",
            "<%= files.riot.generated %>": "<%= files.jade.genJade %>/**/*.tag"
          else
            "<%= files.riot.generated %>": "<%= files.riot.app %>"
    clean: ["<%= files.jade.genJade %>"].concat app.clean if lmfiles.jade

    watch:
      riot:
        files: [
          "<%= files.riotjade.app %>",
          "<%= files.riot.app %>" ]
        tasks:
          if lmfiles.jade
            ["jade:jadeTag", "riot", "concat_sourcemap:js", "clean"]
          else
            ["riot", "concat_sourcemap:js"]
