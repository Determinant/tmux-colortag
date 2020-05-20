Tmux ColorTag theme
-------------------

.. raw:: html

    <div align="center">
    <img src="https://raw.githubusercontent.com/Determinant/tmux-colortag/master/demo.gif" width="95%">
    </div>

What's This?
============

This is a very succinct theme that colors the window tags according to their
names. This means with a proper ``status-interval`` set in your tmux (see
below), it can even automatically change when various programs in your shell
runs!

Installation
============

- If you don't have powerline symbols in your terminal font (or you don't know
  what that is), add the following line to the top of your ``.tmux.conf``:

  ::

    TMUX_COLORTAG_NOPOWERLINE=yes

- Make sure you have tmux plugin manager installed: https://github.com/tmux-plugins/tpm

- Add plugin to the list of TPM plugins in ``.tmux.conf``:

  ::
    
    set -g @plugin 'Determinant/tmux-colortag'

- Hit prefix + I to fetch the plugin and source it.

- Optional: for the best experience, this plugin assumes a short status update
  interval. To change it back, specify ``TMUX_COLORTAG_SET_INTERVAL=no`` or
  directly override the setting in your tmux config file.

- Optional: if you don't like powerline symbols, feel free to change them by
  specifying the following environment variables to override the default:

  - ``TMUX_ARROW_SYMBOL_L1``
  - ``TMUX_ARROW_SYMBOL_L2``
  - ``TMUX_ARROW_SYMBOL_R1``
  - ``TMUX_ARROW_SYMBOL_R2``
