if [ -f ~/.bashrc ]; then
       source ~/.bashrc
   fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rgossiaux/google-cloud-sdk/path.bash.inc' ]; then . '/Users/rgossiaux/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rgossiaux/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/rgossiaux/google-cloud-sdk/completion.bash.inc'; fi

export PATH="$HOME/.cargo/bin:$PATH"
