# Theme based on Bira theme from oh-my-zsh: https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/bira.zsh-theme

function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  set fish_greeting ""
  set -l last_status $status
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l cwd (pwd | sed "s:^$HOME:~:")

function _user_host
  echo -n -s $USER @ (hostname|cut -d . -f 1)
end

  # Output the prompt, left to right

  # Add a newline before new prompts
  #  echo -e ''

  # Display [venvname] if in a virtualenv
  
  # Print pwd or full path
  echo -n -s "$normal""╭─"$green(_user_host) " "
  echo -n -s $blue $cwd $normal

  # Show git branch and status
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)

    if [ (_git_is_dirty) ]
      set git_info $yellow '‹' $git_branch $red "●" $yellow '›' $normal
    else
      set git_info $yellow '‹' $git_branch '›' $normal
    end
    echo -n -s ' ' $git_info $normal
  end

  set -l prompt_color $red
  if test $last_status = 0
    set prompt_color $normal
  end

  # Terminate with a nice prompt char
  echo -e ''
  echo -e -n -s '╰─'$prompt_color'$ ' $normal
end
