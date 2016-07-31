# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to make opened Markdown files always be soft wrapped:
#
# path = require 'path'
#
# atom.workspaceView.eachEditorView (editorView) ->
#   editor = editorView.getEditor()
#   if path.extname(editor.getPath()) is '.md'
#     editor.setSoftWrap(true)
# process.env['PATH'] = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin:/usr/texbin:/Users/hawk/.local/bin:/Users/hawk/.cabal/bin:/Applications/ghc-7.10.2.app/Contents/bin:/Users/hawk/opt/cross/bin:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin:/Applications/Julia-0.3.0.app/Contents/Resources/julia/bin:/usr/local/bin/go:/Users/hawk/Development/go/bin:/Users/hawk/perl5/bin:/usr/local/opt/llvm/bin/"
