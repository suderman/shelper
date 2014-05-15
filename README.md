# shelper

Helper methods for prettier shell scripting  

Note: The shell script is on the gh-pages branch, for the sake of the shorter URL.  

## Installation  

Include this line at the top of your shell script:  
`eval "$(cat ~/.local/share/shelper.sh || curl shelper.suderman.io/shelper.sh)"`  

## Methods

###has  

Pass this a command as an arugument to find out if it exists. For
example:

```
if has tmuxifier; then  
  eval "$(tmuxifier init -)"  
fi
```

```
(has brew) && brew_prefix="$(brew --prefix)"
```

###hasnt  

Exactly the same as the previous method, but the other way around.

###msg  

Pass this a message you want printed out all pretty-like. For example:  

```
msg "Updating the system..."  
```

###ask  

Pass this a message and it will return true if the user presses y.  

###source-curl  

Pass this a local file to try to source, and an URL to curl if it
doesn't exist. For example:

```
source-curl ~/.local/zsh/script.sh example.com/script.sh  
```

###source-existing  

Source a script, but only if it exists on the local file system


###is  

Check shell type and OS

###shelper

Call this to delete the local copy, download a fresh copy, and reload
this script.

