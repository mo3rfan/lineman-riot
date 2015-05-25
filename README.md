![lineman-riot](http://i.imgur.com/gtkQhWe.png)

[![Dependency Status](https://david-dm.org/Power-Inside/lineman-riot.svg)](https://david-dm.org/Power-Inside/lineman-riot)
[![devDependency Status](https://david-dm.org/Power-Inside/lineman-riot/dev-status.svg)](https://david-dm.org/Power-Inside/lineman-riot#info=devDependencies)
[![peerDependency Status](https://david-dm.org/Power-Inside/lineman-riot/peer-status.svg)](https://david-dm.org/Power-Inside/lineman-riot#info=peerDependencies)

[![Build Status](https://travis-ci.org/Power-Inside/lineman-riot.svg?branch=master)](https://travis-ci.org/Power-Inside/lineman-riot)
[![Stories in Ready](https://badge.waffle.io/Power-Inside/lineman-riot.png?label=ready&title=Issues)](https://waffle.io/Power-Inside/lineman-riot)
[![Git tips](https://img.shields.io/gratipay/mohammedirfan1992.svg)](https://gratipay.com/~mohammedirfan1992/)
[![Flattr this](https://button.flattr.com/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=Power-Inside&url=https%3A%2F%2Fgithub.com%2FPower-Inside%2Flineman-riot)
[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Power-Inside/lineman-riot?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

lineman-riot is a plugin for [lineman](http://linemanjs.com) to precompile [RIOT](https://muut.com/riotjs/) tags.

[![NPM](https://nodei.co/npm/lineman-riot.png?downloads=true&downloadRank=true&stars=true)](https://nodei.co/npm/lineman-riot/)

[![Build Status](https://semaphoreci.com/api/v1/projects/2449797f-b721-40e4-bc91-297e07ead4a3/432604/badge.svg)](https://semaphoreci.com/irfan/lineman-riot)

# Usage

At the root of your lineman project, do

```bash
npm install lineman-riot --save-dev
```

> Note: If you're getting errors, you may want to try running npm as root (sudo). If you're on an ancient filesystem that does not support symlinks (FAT32 etc, like mine), try passing the --no-bin-links flag.

The most recent *riot.min.js* will be downloaded and (over)written in `./vendor/js/`.
If that didn't happen for some reason, [download](https://muut.com/riotjs/download.html) a copy of riotjs (without compiler, preferably minified) and place it into `./vendor/js/`

Alternatively (bower fanboys): If you installed the [bower lineman plugin](https://github.com/linemanjs/lineman-bower), you can do `bower install riot` to install the latest riotjs runtime. Make sure you have a bower.json file that specifies riot.js and also extend the js.vendor property to accomodate the downloaded riot.js file. It's all explained [here](https://github.com/linemanjs/lineman-bower#usage). (That's a lot of work!)

A folder called `riottags` will be created in `./app/`. This is where all RIOT custom tags should go. Tags **should** have the extension as .tag

Next, include your custom tags as mount points on your pages (eg, On 'vanilla' lineman projects, that'd be at `./app/pages/index.us`) and [mount](https://muut.com/riotjs/guide/#mounting) them. The riot runtime is made available automatically as a combined javascript file. (`./generated/js/app.js`)

## Modular Javascript
RIOT has support for [AMD/CommonJS](https://muut.com/riotjs/compiler.html#amd-and-commonjs). 

To make use of modular javascript, install any **one** of the following:

* For CommonJS, you can install [lineman-browserify](https://github.com/linemanjs/lineman-browserify/)

* For AMD, install [lineman-requirejs](https://github.com/frisb/lineman-requirejs)

When one of the above plugins are installed, lineman-riot will automatically adjust itself the next time you execute `lineman run` and you need to start using the appropriate syntax and mount as shown in riot.js documentation. (I did not test this, but it should work)

You can also explicitly change the modularization type. Set the override value for `lineman config lm_riot.modular` property in your module exports at `./config/applications.{coffee,js}`. The default value is "*notset*" and that causes it to fall back to CommonJS and then AMD mode (in that order). Supported string values are `amd`,`common` or `umd`.

Example application.coffee configuration:

```CoffeeScript
module.exports -> (lineman)
  app = lineman.config.application
  
  lm_riot:
    modular: "common"
```

## Pre-processor support
 
RIOT compiler currently supports several javascript preprocessors and one HTML preprocessor.

### Javascript preprocessors
 
To write in one of the languages below, make sure you've installed their corresponding compiler modules (shown along side below). If you have them installed globally, that could work too.
After that, you can specify any of them from the custom tags by doing [something along the lines](https://muut.com/riotjs/guide/#pre-processor) of `<script type="text/js_type">` where *js_type* is one of the below:

js_type                                                                          |  NPM package
---------------------------------------------------------------------------------|---------------------------------
*coffeescript* (CoffeeScript is pre-installed along with lineman or this plugin) | `npm update coffee-script`
*es6* (ECMAScript 6)                                                             | `npm install babel` 
*typescript*                                                                     | `npm install typescript-simple`
*livescript*                                                                     | `npm install LiveScript`

If you insist on more, you can try to implement your own custom javascript [riot.parsers on the browser](https://muut.com/riotjs/compiler.html#any-language)

> Note: I'm not sure if the custom parsers can be explicitly implemented in the browser. You might need to play around with the internal ["parser" option](https://github.com/ariesjia/grunt-riot#options) of grunt-riot that we use in this plugin. Extend the riot.compile object's options in your application.{coffee,js} config file. To see the current configuration, type 
```bash
lineman config riot.compile
```

### HTML preprocessors
* *Jade*

The plugin also supports tags created in [Jade](http://jade-lang.com). It's really nice and you should really try it out. You also get the bonus of using Jade templates outside of RIOT (in templates, pages directories etc) To use it, you need to install the [lineman-jade](https://github.com/aranasoft/lineman-jade/) plugin.

After that, write your custom tags in `./app/riottags/` with jade and **save it with .jade extension**. You can still use plain old .tag!

Jade also supports the javascript preprocessors mentioned above. Simply use `script(type="text/livescript")`. Replace "livescript" with your choice of type as mentioned above.

## Credits

Logo credits: [Asad Ullah Khan](https://github.com/Cyber-Logic)

Contributions welcome! Fork and send us a pull request.
