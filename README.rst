Tmux ColorTag theme
-------------------

.. image:: https://raw.githubusercontent.com/Determinant/tmux-colortag/master/demo.gif
   :scale: 100 %

What's This?
============

This is a very succinct theme that colors the window tags according to their
names. This means with a proper ``status-interval`` set in your tmux (see
below), it can even automatically change when various programs in your shell
runs!

Installation
============

- Make sure you have tmux plugin manager installed: https://github.com/tmux-plugins/tpm

- Add plugin to the list of TPM plugins in ``.tmux.conf``:

  ::
    
    set -g @plugin 'Determinant/tmux-colortag'

- Hit prefix + I to fetch the plugin and source it.

- Optional: for the best experience, try to use a short status update interval:

  ::

    set -g status-interval 2

- Optional: if you don't like powerline symbols, feel free to change them by
  specifying the following environment variables to override the default:

  - ``TMUX_ARROW_SYMBOL_L1``
  - ``TMUX_ARROW_SYMBOL_L2``
  - ``TMUX_ARROW_SYMBOL_R1``
  - ``TMUX_ARROW_SYMBOL_R2``
