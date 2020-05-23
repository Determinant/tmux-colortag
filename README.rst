Tmux ColorTag Plugin/Theme
--------------------------

.. raw:: html

    <div align="center">
    <img src="https://raw.githubusercontent.com/Determinant/tmux-colortag/master/demo.gif" width="90%">
    </div>

Also works for powerline haters with default setting.

.. raw:: html

    <div align="center">
    <img src="https://raw.githubusercontent.com/Determinant/tmux-colortag/master/no-powerline-symbol.png" width="70%">
    </div>

What's This?
============

This is a very succinct plugin that colors the window tags according to their
names. The color can even automatically change when your shell runs different
programs! It also serves as a minimal theme that is friendly to any people who
just want something simple and works.

Features
========

- Automically color the window tabs by their name hash
- Manual control of coloring in tmux (also saved)
- Support Powerline symbols

TLDR; I just want it
====================

- Execute the following line in your shell:
  ::

    curl -sS https://raw.githubusercontent.com/Determinant/tmux-colortag/master/bootstrap.sh | bash

- Run ``tmux``, and then hit ``Ctrl+b``, release, then ``I`` so everything should be ready.

Installation
============

- Make sure you have tmux plugin manager installed: https://github.com/tmux-plugins/tpm

- Add it to the list of TPM plugins in ``.tmux.conf``:

  ::
    
    set -g @plugin 'Determinant/tmux-colortag'

- Hit ``prefix`` + ``I`` to fetch the plugin and source it.

- Optional:

  - To immediately play with the main feature, try ``prefix`` (``Ctrl+b`` by default) + ``,`` and change the window name.
  - NOTE: tmux won't change the window name automatically once you set it manually. To test the auto-changing color, just run any command in your new window.

Help
====
Press ``prefix``, then ``C``, type ``help`` and press enter.

Customization
=============

- To manually set the color of the active window tag, press ``prefix`` + ``C`` and:

  - ``color-idx <0-255 color code>`` to manually set the color for the window index
  - ``color-name <0-255 color code>`` to manually set the color for the name
  - ``clear-idx`` clears the preivous color of the index
  - ``clear-name`` clears the preivous color of the name
  - ``clear-all`` use auto-coloring for all window tags

.. raw:: html

    <div align="center">
    <img src="https://raw.githubusercontent.com/Determinant/tmux-colortag/master/demo-manual-coloring.gif" width="90%">
    </div>

- If you would like to use Powerline symbols like shown in the demo, add the
  following line to the top of your ``.tmux.conf`` to enable them:

  ::

    TMUX_COLORTAG_USE_POWERLINE=yes

- To change the prompt key (``prefix`` + ``C``), specify your key in ``TMUX_COLORTAG_KEY``.

- TIP: If you love the status bar on the top (instead of at the bottom by default in tmux), add ``set-option -g status-position top`` to your config file

- Other tweakable variables:

  - ``TMUX_COLORTAG_TAG_BOLD``: specify ``yes`` if you want bold tag text
  - ``TMUX_COLORTAG_TAG_FOCUS_HIGHLIGHT``: specify ``yes`` if you want highlighted text for the active tag
  - ``TMUX_COLORTAG_TAG_FOCUS_UNDERLINE``: specify ``yes`` if you want underlined text for the active tag
  - ``TMUX_ARROW_SYMBOL_L1``
  - ``TMUX_ARROW_SYMBOL_L2``
  - ``TMUX_ARROW_SYMBOL_R1``
  - ``TMUX_ARROW_SYMBOL_R2``
  - ``TMUX_COLORTAG_SET_INTERVAL``: for the best experience, this plugin
    assumes a short status update interval. To change it back, make it ``no`` or
    directly override the setting in your tmux config file.

  - ``TMUX_COLORTAG_TAG_ONLY``: if you only want to color the tags (without
    changing other styles such as borders), make it ``yes``.

  - ``TMUX_COLORTAG_IDX_SEP``: controls the separator between the window index and name.
  - Theme colors (value example: "colour123")

    - ``colortag_bg0``
    - ``colortag_bg1``
    - ``colortag_white0``: font color of the active tag
    - ``colortag_white1``: color of the active pane border
    - ``colortag_lightgray``
    - ``colortag_darkgray``

Update to the Latest Version
============================

- Hit ``prefix`` + ``U`` and choose this plugin.
