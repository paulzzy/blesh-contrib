[ Languages: **English** | [日本語](README-ja.md) (Japanese) ]

# blesh-contrib
Settings for [akinomyoga/ble.sh](https://github.com/akinomyoga/ble.sh)

Unless otherwise specified, files in this repository is licensed by [BSD 3-clause license](LICENSE).
The files in `airline` are licensed by the MIT License.

## :pencil: fzf integration

Source: [`fzf-completion.bash`](https://github.com/akinomyoga/blesh-contrib/blob/master/fzf-completion.bash),
  [`fzf-key-bindings.bash`](https://github.com/akinomyoga/blesh-contrib/blob/master/fzf-key-bindings.bash)

Note: If you would like to integrate `fzf-completion` with `bash-completion`, `bash-completion` needs to be loaded before `fzf-completion` is loaded.

### Option 1: Setup in `~/.fzf.bash`

If you would like to use fzf with `ble.sh`, you can rewrite your `.fzf.bash` in the following way (please replace `/path/to/fzf-directory` by your fzf path (e.g., `$HOME/.fzf`), the path to the **fzf directory** but not the fzf binary):

```bash
# fzf.bash

# Setup fzf
# ---------
_ble_contrib_fzf_base=/path/to/fzf-directory
if [[ ! "$PATH" == *"$_ble_contrib_fzf_base/bin"* ]]; then
  export PATH="${PATH:+${PATH}:}$_ble_contrib_fzf_base/bin"
fi

# Auto-completion
# ---------------
if [[ ${BLE_VERSION-} ]]; then
  ble-import -d contrib/fzf-completion
else
  [[ $- == *i* ]] && source "$_ble_contrib_fzf_base/shell/completion.bash" 2> /dev/null
fi

# Key bindings
# ------------
if [[ ${BLE_VERSION-} ]]; then
  ble-import -d contrib/fzf-key-bindings
else
  source "$_ble_contrib_fzf_base/shell/key-bindings.bash"
fi
```

### Option 2: Setup in `~/.blerc`

Or, you can directly write settings in your `blerc` as follows (please replace `/path/to/fzf-directory` by your fzf path).
In this case do not source `.fzf.bash` in your `.bashrc`.

```bash
# blerc

# Setup fzf
_ble_contrib_fzf_base=/path/to/fzf-directory
ble-import -d contrib/fzf-completion
ble-import -d contrib/fzf-key-bindings
```

## :pencil: `contrib/fzf-git`

Source: [`fzf-git.bash`](https://github.com/akinomyoga/blesh-contrib/blob/master/fzf-git.bash)

You can use [fzf-git](https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236) settings for `ble.sh` with the following settings.

```bash
# bashrc / fzf.bash
if [[ ${BLE_VERSION-} ]]; then
  _ble_contrib_fzf_base=/path/to/fzf-directory
  _ble_contrib_fzf_git_config=key-binding:sabbrev:arpeggio
  ble-import -d contrib/fzf-git
fi
```

Or you can configure it in `~/.blerc`:

```bash
# blerc
_ble_contrib_fzf_base=/path/to/fzf-directory
_ble_contrib_fzf_git_config=key-binding:sabbrev:arpeggio
ble-import -d contrib/fzf-git
```

The shell variable `_ble_contrib_fzf_git_config` is a colon-separated list of the enabled types of bindings.
The value `key-binding` enables the key bindings of the form <kbd>C-g C-f</kbd>, <kbd>C-g C-b</kbd>, <kbd>C-g C-t</kbd>, <kbd>C-g C-h</kbd> and <kbd>C-g C-r</kbd>.
The value `sabbrev` enables the sabbrev expansion for the words `gf`, `gb`, `gt`, `gh` and `gr`.
The value `arpeggio` enables the simultaneous key combinations of <kbd>g f</kbd>, <kbd>g b</kbd>, <kbd>g t</kbd>, <kbd>g h</kbd> and <kbd>g r</kbd>.

# &#x2699; Prompt sequences

## :pencil: `contrib/prompt-vim-mode`

Source: [`prompt-vim-mode.bash`](https://github.com/akinomyoga/blesh-contrib/blob/master/prompt-vim-mode.bash)

### Prompt sequence `\q{contrib/vim-mode}`

This prompt sequence expands to the vim mode name.

```bash
# blerc (example)

ble-import contrib/prompt-vim-mode
PS1='[\u@\h \W]\q{contrib/vim-mode}\$ ' # show mode name in PS1
bleopt keymap_vi_mode_show:=            # hide mode line
```

## :pencil: `contrib/prompt-git`

Source: [`prompt-git.bash`](https://github.com/akinomyoga/blesh-contrib/blob/master/prompt-git.bash)

```bash
# blerc (example)

ble-import contrib/prompt-git
bleopt prompt_rps1='\q{contrib/git-info}'
```

### Prompt sequence `\q{contrib/git-info}`

This expands to a string that explains the current git status.

### Prompt sequence `\q{contrib/git-name}`

This expands to the directory name of the repository.

### Prompt sequence `\q{contrib/git-hash N}`

This expands to the commit hash.
The hash is truncated to the length `N`.
The default value for `N` is `7`.

### Prompt sequence `\q{contrib/git-branch}`

This expands to the branch name (or tag name or hash) of `HEAD`.

### Prompt sequence `\q{contrib/git-path}`

This expands to the current path relative to the root directory of the repository.

## :pencil: `contrib/prompt-elapsed`

Source: [`prompt-elapsed.bash`](https://github.com/akinomyoga/blesh-contrib/blob/master/prompt-elapsed.bash)

Measures the time of the previous command execution.

```bash
# blerc (example)

ble-import contrib/prompt-elapsed
bleopt prompt_rps1='\g{fg=69,italic}\q{contrib/elapsed}'
```

### Prompt sequence `\q{contrib/elapsed}`

This expands to the high-resolution elapsed time for the command execution.

### Prompt sequence `\q{contrib/elapsed-real}`

This expands to the `real` time of `time`.

### Prompt sequence `\q{contrib/elapsed-user}`

This expands to the `user` time of `time`.

### Prompt sequence `\q{contrib/elapsed-sys}`

This expands to the `sys` time of `time`.

### Prompt sequence `\q{contrib/elapsed-cpu}`

This expands to the average cpu usage.

## :pencil: colorglass

If your terminal supports the 24-bit color, you can adjust the theme colors by specifying gamma, contrast, hue rotation, etc.

```bash
ble-import contrib/colorglass
```

### Blopet colorglass_gamma

This option specifies the change of gamma by percentage.
For example, `bleopt colorglass_gamma=5` performs the gamma correction with $\gamma=1.05$, and `bleopt colorglass_gamma=-5` performs the gamma correction with $\gamma=0.95$

```bash
# default
bleopt colorglass_gamma=0
```

### Blopet colorglass_contrast

This option specifies the contrast modification in the range -100..100.

```bash
# default
bleopt colorglass_contrast=0
```

### Blopet colorglass_rotate

This option specifies the angle of hue rotation in degrees.

```bash
# default
bleopt colorglass_rotate=0
```

### Blopet colorglass_alpha

This option specifies the opacity in the range 0..255 when the color is synthesized with the background color specified by `bleopt colorglass_color`.

```bash
# defualt
bleopt colorglass_alpha=255
```

### Blopet colorglass_color

This option specifies the background color used by the color synthesis by `bleopt colorglass_alpha`.

```bash
# defualt
bleopt colorglass_color=0x8888FF
```
