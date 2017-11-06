module.exports = {
  config: {
      // default font size in pixels for all tabs
      fontSize: 14,

      // font family with optional fallbacks
      fontFamily: "Iosevka Nerd Font",

      // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    //   cursorColor: '#c0c5ce',
    cursorColor: '#ffffff',

      // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
      cursorShape: 'BLOCK',

      // color of the text
    //   foregroundColor: '#c0c5ce',
    foregroundColor: "#ffffff",

      // terminal background color
    //   backgroundColor: '#2b303b',
    backgroundColor: '#5A5475',

      // border color (window, tabs)
      borderColor: '#5A5475',

      // custom css to embed in the main window
      css:
   // `
   //        .header_header {
   //          top: 0;
   //          right: 0;
   //          left: 0;
   //        }
   //        .tabs_list {
   //          background-color: #1c1f26 !important;
   //          border-bottom-color: #1c1f26  !important;
   //        }
   //        .tab_tab.tab_active {
   //          font-weight: 500;
   //          background-color: #2b303b;
   //            border-color: #2b303b !important;
   //        }
   //        .tab_tab.tab_active::before {
   //            border-bottom-color: #2b303b ;
   //        }
   ``,
   //    `,

      // custom css to embed in the terminal window
      termCSS:
      `
      .cursor-node {
          mix-blend-mode: difference;
      }
      * {
          text-rendering: optimizeLegibility;
          -webkit-font-feature-settings: "liga" on, "calt" on, "ss08" on;
          font-feature-settings: "liga" on, "calt" on, "ss08" on;
      }
      .unicode-node {
          display: inline !important;
           vertical-align: top !important;
           width: 1em !important;
    }
  `,
    // ``,
      // custom padding (css format, i.e.: `top right bottom left`)
      padding: '18px 20px',


    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
        // black: '#2B303B',
        black: '#5A5475',
        // red: '#bf616a',
        red: '#FF857F',
        // green: '#98be8c',
        green: '#C2FFDF',
        yellow: '#ebcb8b',
        blue: '#406495',
        // magenta: '#b48ea7',
        magenta: '#FFB8D1',
        cyan: '#8abeb7',
        white: '#ffffff',
        lightBlack: //'#272432',
        '#C5A3FF',
        // lightRed: '#de935f',
        lightRed: '#F92672',
        lightGreen: '#98be8c',
        // lightYellow: '#ebcb8b',
        lightYellow: "#FFF352",
        // lightBlue: '#708ab3',
        lightBlue: '#272432',
        // lightMagenta: '#b48ea7',
        lightMagenta: '#FFB8D1',
        // lightCyan: '#96b5b4',
        lightCyan: '#C5A3FF',
        lightWhite: '#e2e4ea'

    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: '/usr/local/bin/zsh',

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to false for no bell
    bell: 'SOUND',

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: false,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',
    //
    // // for advanced config flags please refer to https://hyper.is/#cfg
    // // hyperline: {
    // //     color: 'yellow',
    // // }
    //  hyperStatusLine: { fontSize: 12
    //                   , dirtyColor: '#ebcb8b'
    //                   , arrowsColor: '#b48ea7'
    //                 //   , footerTransparent: false
    //                   }
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: ["hyperlinks", "hyper-tabs-enhanced", "hyperterm-paste", "hypercwd"],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: []
};
