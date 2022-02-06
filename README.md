# My neovim dotfiles

### Requirements

* neovim >= 0.6
* rg
* git, unzip, curl, tar, ...

### Install and setup configuration:

```bash
git clone https://github.com/wisdom-yzh/nvim-dotfiles ~/.config/nvim
git submodule update --init --recursive
nvim +PackerSync
```

### Key bindings

#### Auto complete

`Ctrl - Space`: Trigger auto complete

`, + a`: Toggle code action to current cursor

#### Debugger

`, + b`: Toggle breakpoints

`, + r`: Start debugging / Attach

`, + Shift - r`: End debugging / Detach

`, + n`: Step over

`, + s`: Step into

`, + Shift - s`: Step out

`, + p`: Hover on variable

#### Search

`Ctrl + c`: Grep cursor word in current file

`Ctrl + p`: Find files in repository

`Meta + p`: Live grep word in repository (using rg)

`Shift + p`: Grep cursor word in repository (using rg)

`Meta + a`: Sending all results to quick flist when in searching panel

#### Git

`, + gl`: Show git logs of current file

`, + gb`: Show git blame of current file

`, + gg`: Open Git UI

In Git UI:

`-`: git add / stage current file

`dv`: show git diff

`cc`: git commit

`ca`: git commit amend

`X`: git revert current file

#### Auto jump

`, + c`: Goto definition in a vertical split window

`, + d`: Goto declaration in a vertical split window

`, + Shift - d`: Goto implementation in a vertical split window

`, + Shift - c`: Goto references in a vertical split window

#### Diagnostic

`, + w`: Show diagnostic error list

#### Tree lists

`, + ,`: Toggle file explorer

`, + .`: Toggle file explorer and show current file under cursor

`, + t`: Toggle outline of current file
