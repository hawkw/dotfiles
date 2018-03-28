module.exports = {
  config: {
      // default font size in pixels for all tabs
      fontSize: 14,

      // font family with optional fallbacks
      fontFamily: "Iosevka Nerd Font",
      fontWeight: '300',
      fontWeightBold: '500',

      // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    //   cursorColor: '#c0c5ce',
    cursorColor: '#A6ACCD',

      // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
      cursorShape: 'UNDERLINE',

      // color of the text
    //   foregroundColor: '#c0c5ce',
    foregroundColor: "#A6ACCD",

      // terminal background color
    //   backgroundColor: '#2b303b',
    backgroundColor: '#292D3E',
    // backgroundColor: 'rgba(90, 84, 117, .85)',
    // backgroundColor: '#272432',

      // border color (window, tabs)
      borderColor: 'rgba(90, 84, 117, .1)',

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
          // text-rendering: optimizeLegibility;
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
      // padding: '5px 5px',


  //   MaterialTheme: {
  //     // Set the theme variant,
  //     // OPTIONS: 'Darker', 'Palenight', ''
  //     theme: 'Palenight',

  //     // [Optional] Set the rgba() app background opacity, useful when enableVibrance is true
  //     // OPTIONS: From 0.1 to 1
  //     backgroundOpacity: '0.8',

  //     // [Optional] Set the accent color for the current active tab
  //     accentColor: '#64FFDA',

  //     // [Optional] Mac Only. Need restart. Enable the vibrance and blurred background
  //     // OPTIONS: 'dark', 'ultra-dark', 'bright'
  //     // NOTE: The backgroundOpacity should be between 0.1 and 0.9 to see the effect.
  //     vibrancy: 'dark'
  // },

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: '#676E95',
      red: '#FF5253',
      green: '#C3E88B',
      yellow: '#FFD740',
      blue: '#40C4FF',
      magenta: '#FF4081',
      cyan: '#64FCDA',
      white: '#A6ACCD',
      lightBlack: 'B0B3C5',
      lightRed: '#FF7F86',
      lightGreen: '#B9F6CA',
      lightYellow: "#FFE37F",
      lightBlue: '#80D5FF',
      lightMagenta: '#FF80AB',
      lightCyan: '#A7FDE8',
      lightWhite: '#C6D0F3'

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
  plugins:
    [ "hyperlinks"
    , "hyper-tabs-enhanced"
    , "hyperterm-paste"
    , "hypercwd"
    , 'hyper-statusline'
    , "hyper-tab-icons-plus"
    // , 'hyper-material-theme'
    ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: []
};
