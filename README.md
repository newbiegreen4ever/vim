# My Vim Setting

## Why I upload my vim setting

I upload my gVimPortable settings for the following reasons

1. Backup of my vimrc and pack files
1. Record how I tinker with my Vim with commits

## What's insider

### Idea behind my vim setting

This is a minimal configuration for Vim newbies, mostly for myself.
I have just started to play with Vim in September 2017 because of Atom startup drag.
Atom is a decent text editor, but my computer is too slow for it.
The learning curve is not as crazy as people say, it is actually quite smooth.

This is not meant to be a feature-rich configurations, unlike those crafted by experienced users.
I came across a few, but I decided to configure my own vim setting because that is what Vim is about - **configuration**

I organize what I have found and learnt in this configuration.
I keep the numbers of plugin to minimal level.
There is no statusline plugin because I find it too clumsy to install a plugin when you can achieve similar effect with a few lines of codes in vimrc.
I keep the original file explorer rather than installing NERDTree for the same reason.

### 1. Vimrc

There are 13 sections in my vimrc, namely

1. Basic setting
1. General setting
1. Visual setting
1. Statusline setting
1. Search setting
1. Indent setting
1. Bracket setting _(need amendment)_
1. Mapping setting
1. Abbreviation setting
1. Helper function
1. Autocmd setting _(vacant)_
1. Plugin setting
1. Folding setting

Helper function section comprises of handy Vimscript tricks collected from internet.
Unfortunately, I still cannot come up with something useful in Vimscript on my own at this stage.

### 2. Pack files

Pack is the native plugin manager shipped with Vim. 
Many still prefer third-party plugin manager such as Vundle or Pathogen for their richer functions.
I just want a straightforward way to handle my plugin, so I stick with Pack.

Plugins are categorized as "start" or "opt" at pack directory.
1. `vimfiles\pack\<yourname>\start`
1. `vimfiles\pack\<yourname>\opt`

I know there are a lot of good plugins out there. 
For the time being, I will only include what I can comfortably use.

#### Start

Vim will load all plugins at `vimfiles\pack\<yourname>\start` on startup.
I try to keep minimal number of plugins under start section.

1. nerdcommenter
1. vim-autoclose
1. vim-surround

#### Opt

Vim will load plugins at `vimfiles\pack\<yourname>\start` under `packadd` command eg `:packadd vimwiki`.

**Writing notes**

- vimwiki
- goyo
- limelight

**Writing frontend code**

- indent-guides
- jsbeautify
- emmet

