
# TODO

  * [Dired Omit Mode](https://www.emacswiki.org/emacs/DiredOmitMode) (with sqk file?)
  * Helm global prefix not enabled. if i like helm enable
  * Improve camel to snake command
  * Setup include dir for non melpa/elpa packges
  * Python
      * [doctest mode](http://ed.loper.org/projects/doctestmode/)
      * Prefix a symbol with _ w/in a file,
          * query-replace-regexp of following major word (including underscores) of word -> _\&
      * default C-c C-v linter is pylint, not epylint (unless i can configure epylint nicely)
	  * "TODO" comment coloring.
	  * Autofill (autowrap) when inside docstrings (exordium does this -- ask philippe?)

# BUGS
  * Markdown live preview doesn't support lists. Fix?

# CHECKOUT
  * Checkout org mode
  * Hippie expand
  * YASnippet

# REPO
  * would be cool to have a jenkins build on PR's to check that emacs init.el doesn't break.
  * Update github documentation in README
	  * Include simple instructions for me and others on how to actually get started with some of these packages, such as magit, helm, etc.

# MAC
  * Emacsclient return focus to terminal after killing: [stackoverflow post](https://stackoverflow.com/questions/47496959/how-to-return-focus-to-terminal-after-closing-gui-emacsclient-on-mac-os-x)

# PROJECTS
  * re-builder (or similar equivalent) with python style raw string regexes
	  * an internal emacs [regex101](https://regex101.com/) would be awesome
  * Magit
	  * Special command to automatically stage, commit & push all root level markdown files.
  * Python
	  * parse_args wizard builder
	  * Python docstring wizard
		  * For all undocumented modules, add documentation
		  * For function: Args: Returns:
		  * For classes/modules: Available features.
		  * Interactive minibuffer
