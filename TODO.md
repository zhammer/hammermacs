
# TODO
  * Install org mode -- maybe convert todo to org mode file.
  * Emacsclient return focus to terminal after killing: [stackoverflow post](https://stackoverflow.com/questions/47496959/how-to-return-focus-to-terminal-after-closing-gui-emacsclient-on-mac-os-x)
  * re-builder (or similar equivalent) with python style raw string regexes
      * an internal emacs [regex101](https://regex101.com/) would be awesome
  * would be cool to have a jenkins build on PR's to check that emacs init.el doesn't break.
  * Markdown live preview doesn't support lists. Fix?
  * [Dired Omit Mode](https://www.emacswiki.org/emacs/DiredOmitMode) (with sqk file?)
  * Try out [Magit](https://github.com/magit/magit)
  * Delay to turn on ido? I like the cleaner display at first
      * Maybe just C-i to switch to ido mode from regular search?
  * Update github documentation in README
      * Include simple instructions for me and others on how to actually get started with some of these packages, such as magit, helm, etc.
  * Magit
      * Special command to automatically stage, commit & push all root level markdown files.
  * Helm global prefix not enabled. if i like helm enable
  * Convert all snake case to camel or visa versa. Perhaps a gui that displays all names, can select which to apply to.
  * Python
      * TODO comment coloring.
      * Autofill (autowrap) when inside docstrings (see [python-docstring-mode](https://github.com/glyph/python-docstring-mode))
      * Python docstring wizard
          * For all undocumented modules, add documentation
          * For function: Args: Returns:
          * For classes/modules: Available features.
          * Interactive minibuffer
