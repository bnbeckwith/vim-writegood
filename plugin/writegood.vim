" ============================================================================
" File:        writegood.vim
" Description: vim global plugin to fix poor writing
" Maintainer:  Benjamin Beckwith <bnbeckwith@gmail.com>
" ============================================================================

let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_writegood")
  finish
endif

if !exists('g:writegood_weasel_words')
  let g:writegood_weasel_words = ['many', 'various', 'very', 'fairly', 'several',
        \ 'extremely', 'exceedingly', 'quite', 'remarkably', 'few', 'surprisingly', 
        \ 'mostly', 'largely', 'huge', 'tiny', 'are a number', 'is a number', 
        \ 'excellent', 'interestingly', 'significantly', 'substantially', 
        \ 'clearly', 'vast', 'relatively', 'completely', 'literally', 
        \ 'not rocket science', 'outside the box']
  if exists('g:writegood_user_weasel_words')
    let g:writegood_weasel_words += g:writegood_user_weasel_words
  endif
endif


if !exists('g:writegood_passive_voice_irregulars')
  let g:writegood_passive_voice_irregulars = [
    \ 'awoken', 'been', 'born', 'beat', 'become', 'begun', 'bent', 'beset',
    \ 'bet', 'bid', 'bidden', 'bound', 'bitten', 'bled', 'blown', 'broken',
    \ 'bred', 'brought', 'broadcast', 'built', 'burnt', 'burst', 'bought',
    \ 'cast', 'caught', 'chosen', 'clung', 'come', 'cost', 'crept', 'cut',
    \ 'dealt', 'dug', 'dived', 'done', 'drawn', 'dreamt', 'driven', 'drunk',
    \ 'eaten', 'fallen', 'fed', 'felt', 'fought', 'found', 'fit', 'fled',
    \ 'flung', 'flown', 'forbidden', 'forgotten', 'foregone', 'forgiven',
    \ 'forsaken', 'frozen', 'gotten', 'given', 'gone', 'ground', 'grown',
    \ 'hung', 'heard', 'hidden', 'hit', 'held', 'hurt', 'kept', 'knelt', 'knit',
    \ 'known', 'laid', 'led', 'leapt', 'learnt', 'left', 'lent', 'let', 'lain',
    \ 'lighted', 'lost', 'made', 'meant', 'met', 'misspelt', 'mistaken', 'mown',
    \ 'overcome', 'overdone', 'overtaken', 'overthrown', 'paid', 'pled', 'proven',
    \ 'put', 'quit', 'read', 'rid', 'ridden', 'rung', 'risen', 'run', 'sawn',
    \ 'said', 'seen', 'sought', 'sold', 'sent', 'set', 'sewn', 'shaken', 'shaven',
    \ 'shorn', 'shed', 'shone', 'shod', 'shot', 'shown', 'shrunk', 'shut',
    \ 'sung', 'sunk', 'sat', 'slept', 'slain', 'slid', 'slung', 'slit',
    \ 'smitten', 'sown', 'spoken', 'sped', 'spent', 'spilt', 'spun', 'spit',
    \ 'split', 'spread', 'sprung', 'stood', 'stolen', 'stuck', 'stung',
    \ 'stunk', 'stridden', 'struck', 'strung', 'striven', 'sworn', 'swept',
    \ 'swollen', 'swum', 'swung', 'taken', 'taught', 'torn', 'told', 'thought',
    \ 'thrived', 'thrown', 'thrust', 'trodden', 'understood', 'upheld', 'upset',
    \ 'woken', 'worn', 'woven', 'wed', 'wept', 'wound', 'won', 'withheld',
    \ 'withstood', 'wrung', 'written']
endif

if !exists('g:writegood_passive_voice_verbs')
  let g:writegood_passive_voice_verbs = [
        \ 'am', 'are', 'were', 'being', 'is', 'been', 'was', 'be' ]
endif

let s:writegood_weasels_regexp = '\<\(' . join(g:writegood_weasel_words, '\|') . '\)\>'
let s:writegood_passive_voice_irregulars_regexp = '\<\(' . join(g:writegood_passive_voice_verbs, '\|') .
      \ '\)\>\(\s\|\n\)\+\<\(\w\+ed\|'. join(g:writegood_passive_voice_irregulars, '\|') . '\)\>'
let s:writegood_duplicates_regexp = '\(\<\w\+\>\)\s\+\1'

function! s:make_highlights()
  if !hlexists("WritegoodWeaselWords")
    highlight def WritegoodWeaselWords term=bold gui=undercurl guisp=Yellow
  endif
  if !hlexists("WritegoodPassiveVoice")
    highlight def WritegoodPassiveVoice term=bold gui=undercurl guisp=Magenta
  endif
  if !hlexists("WritegoodDuplicates")
    highlight def WritegoodDuplicates term=bold gui=undercurl guisp=Cyan
  endif
endfunction

function! s:WritegoodToggle()
  let w:wg_check_words = exists('w:wg_check_words') ? !w:wg_check_words : 1

  call s:make_highlights()

  if w:wg_check_words
    let w:ww   = matchadd('WritegoodWeaselWords', s:writegood_weasels_regexp)
    let w:dups = matchadd('WritegoodDuplicates', s:writegood_duplicates_regexp)
    let w:pvi  = matchadd('WritegoodPassiveVoice', s:writegood_passive_voice_irregulars_regexp)
    echom "Writegood on"
  else
    call matchdelete(w:ww)
    call matchdelete(w:dups)
    call matchdelete(w:pvi)
    echom "Writegood off"
  endif
endfunction

if !hasmapto('<Plug>WritegoodToggle')
  map <unique> [wg <Plug>WritegoodToggle
endif
noremap <unique> <script> <Plug>WritegoodToggle <SID>WritegoodToggle
noremap <SID>WritegoodToggle :call <SID>WritegoodToggle()<CR>

if !exists(":Writegood")
  command -nargs=0 Writegood :call s:WritegoodToggle()
endif

let g:loaded_writegood = 1
let &cpo = s:save_cpo
unlet s:save_cpo

