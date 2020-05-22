Tmux ColorTag Theme
-------------------

.. raw:: html

    <div align="center">
    <img src="https://raw.githubusercontent.com/Determinant/tmux-colortag/master/demo.gif" width="90%">
    </div>

Also...works for powerline haters using the default setting.

.. raw:: html

    <div align="center">
    <img src="https://raw.githubusercontent.com/Determinant/tmux-colortag/master/no-powerline-symbol.png" width="90%">
    </div>

What's This?
============

This is a very succinct theme that colors the window tags according to their
names. The color can even automatically change when your shell runs different
programs!

Features
========

- Support Powerline symbols
- Automically color the window tabs by their name hash
- Allow manual coloring

Installation
============

- Make sure you have tmux plugin manager installed: https://github.com/tmux-plugins/tpm

- Add plugin to the list of TPM plugins in ``.tmux.conf``:

  ::
    
    set -g @plugin 'Determinant/tmux-colortag'

- Hit ``prefix`` + ``I`` to fetch the plugin and source it.

- Optional:

  - To immediately play with the main feature, try ``prefix`` (``Ctrl+b`` by default) + ``,`` and change the window name.
  - NOTE: tmux won't change the window name automatically once you set it manually. To test the auto-changing color, just run any command in your new window.

Customization
=============

- To manually set the color of the active window tag, press ``prefix`` + C and:

  - ``color-idx <256 color code>`` to manually set the color for the window index
  - ``color-name <256 color code>`` to manually set the color for the name
  - ``clear-idx`` clears the preivous color of the index
  - ``clear-name`` clears the preivous color of the name
  - ``clear-all`` use auto-coloring for all window tags

- If you would like to use Powerline symbols like shown in the demo, add the
  following line to the top of your ``.tmux.conf`` to enable them:

  ::

    TMUX_COLORTAG_USE_POWERLINE=yes

- If you don't like the existing powerline symbols, feel free to change them by
  specifying the following environment variables to override the default:

  - ``TMUX_ARROW_SYMBOL_L1``
  - ``TMUX_ARROW_SYMBOL_L2``
  - ``TMUX_ARROW_SYMBOL_R1``
  - ``TMUX_ARROW_SYMBOL_R2``

- TIP: If you love the status bar on the top (instead of at the bottom by default in tmux), add ``set-option -g status-position top`` to your config file

- For the best experience, this plugin assumes a short status update
  interval. To change it back, specify ``TMUX_COLORTAG_SET_INTERVAL=no`` or
  directly override the setting in your tmux config file.

- If you only want to color the tags (without changing other styles
  such as borders), specify ``TMUX_COLORTAG_TAG_ONLY=yes``.

- ``TMUX_COLORTAG_IDX_SEP`` controls the separator between the window index and name.

Update to the Latest Version
============================

- Hit ``prefix`` + ``U`` and choose this plugin.
