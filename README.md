# writegood.vim

Use writegood.vim to highlight problems with your writing.  It checks for
weasel words, passive voice and duplicates.

[Matt Might's weaselwords scripts](http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/)
inspired the original Emacs mode. 
  
## Installation

Assuming you are using some kind of bundling system:

```
cd ~/.vim/bundle
git clone git://github.com/bnbeckwith/vim-writegood.git
```

Next, map the `WritegoodToggle` function to a key:
```
nnoremap <C-w> :WritegoodToggle<CR> 
```

## Features

For the specific defaults, check out the [source](plugin/writegood.vim). 

### Weasel Words

These words seem to add value to text, but are not specific and can usually be removed.

There is a default list of words, but you are welcome to add your own.  Just set `g:writegood_user_weasel_words` like:

```
let g:writegood_user_weasel_words = ["emacs"]
```

### Passive Voice

Writing in the active voice is preferred. This check highlights areas that look like passive voice.

### Duplicates 

The duplicates check looks for the same word back-to-back. No customization is necessary here.

## License

Copyright © 2016 Benjamin Beckwith. Distributed under the same terms as Vim itself.
See `:help license`
