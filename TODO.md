
# TODO
  * STORE BACKUP FILES IN ONE LOCATION!
  * C++
      * Setup some compile commands for running makefiles, etc.
  * yas-good-grace doesn't seem to be working
  * key binding for init-edit and 4 prefix for edit in other window
  * adjustable privatization levels for python privatize function
  * python yasnippets
      * def function w/ args
          * optional 'raises' field
      * _parse_args function template
          * optional and positional args as well
  * Setup modules dir and init-*.el files
  * Add to dired omit mode
  * Helm global prefix not enabled. if i like helm enable
  * Improve camel to snake command
  * Setup include dir for non melpa/elpa packges
  * http://cupfullofcode.com/blog/2013/02/26/snippet-expansion-with-yasnippet/index.html
  * Python
	  * Autofill (autowrap) when inside docstrings

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
