module.exports = (lineman) ->
  app = lineman.config.application
  lmfiles = lineman.config.files
  
  files:
    riotjade:
      app: "app/riottags/**/*.jade"
    riot:
      app: "app/riottags/**/*.tag"
      generated: "generated/js/riot.riot.js"
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
            if app.browserify
              type: 'common'
              deps: 'riot'
            else
              false
        files:
          if lmfiles.jade
            "<%= files.riot.generated %>": "<%= files.riot.app %>",
            "<%= files.riot.generated %>": "<%= files.jade.genJadetags %>/**/*.tag"
          else
            "<%= files.riot.generated %>": "<%= files.riot.app %>"
    clean: ["<%= files.jade.genJadetags %>"].concat app.clean if lmfiles.jade

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
