# shelper

Helper methods for prettier shell scripting  

Note: The shell script is on the gh-pages branch, for the sake of the shorter URL.  

## Installation  

Include this line at the top of your shell script:  
`eval "$(cat ~/.local/share/shelper.sh || curl suderman.github.io/shelper/shelper.sh)"`  

## Methods

###has  

Pass this a command as an argument to find out if it exists. For
example:

```
if has tmuxifier; then  
  eval "$(tmuxifier init -)"  
fi
```

```
(has brew) && brew_prefix="$(brew --prefix)"
```

This also works with files and directories. For example:  

```
(has ~/.vimrc) || echo "Don't you like Vim?"
```  

###hasnt  

Exactly the same as the previous method, but the other way around.  

###msg  

Pass this a message you want printed out all pretty-like. For example:  

```
msg "Updating the system..."  
```

###ask  

Pass this a message and it will return true if the user presses `y`. For
example:  

```
if ask "Are you sure?"; then  
  echo "Okay, great!"
fi
```

###source    

Pass this a local file to try to source (this is normal behaviour). 
For example:

```
source ~/.local/zsh/script.sh    
```  

Pass this a URL to a remote script, saving it to the cache for later 
use. For example:

```
source www.example.com/script.sh  
```  

Pass this a local file to try to source, and an URL to fall back on 
if it doesn't exist. For example:  

```
source ~/.local/zsh/script.sh www.example.com/script.sh  
```

###source if   

Source a script, but only if it exists on the local file system. For
example:

```
source if ~/.local/zsh/script.sh  
```

###source new  

Source a remote script, skipping the cache and fetching it new. For
example:

```
source new www.example.com/script.sh  
```

###is  

Check type of shell and OS. For example:  

```
(is bash) && echo "This shell is Bash"    
(is zsh) && echo "This shell is ZSH"    
(is osx) && echo "This OS is OS X"    
(is ubuntu) && echo "This OS is Ubuntu"    
```

###cp    

Give this a source file and a destination file to copy to. This is normal behaviour, except the destination will always be overwritten and directories will always copy recursvively (`cp -rf`).  When overwriting, a backup copy of the destination is created (.bak) in the destination's directory. Also, the destination's directory structure will be built if neccessary with `mkdir -p`.  

For example:

```
cp ~/downloads/file.txt ~/unmade/nested/directories/myfile.txt   
```  

Alternatively pass a URL as the source to download the remote file to the local destination. For example:

```
cp www.example.com/file.txt ~/unmade/nested/directories/myfile.txt   
```  


###shelper

Call this to delete the local copy, download it fresh, and then reload
this script.

