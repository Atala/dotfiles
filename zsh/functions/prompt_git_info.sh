#http://sebastiancelis.com/2009/11/16/zsh-prompt-git-users/
local st="$(git status 2>/dev/null)"
if [[ -n "$st" ]]; then
	local -a arr
	arr=(${(f)st})

	if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
		__CURRENT_GIT_BRANCH='no-branch'
	else
		__CURRENT_GIT_BRANCH="${arr[1][(w)4]}";
	fi
	
	if [[ $arr[2] =~ 'Your branch is' ]]; then
		if [[ $arr[2] =~ 'ahead' ]]; then
			__CURRENT_GIT_BRANCH_STATUS='ahead'
		elif [[ $arr[2] =~ 'diverged' ]]; then
			__CURRENT_GIT_BRANCH_STATUS='diverged'
		else
			__CURRENT_GIT_BRANCH_STATUS='behind'
		fi
	fi
	if [[ ! $st =~ 'nothing to commit' ]]; then
		__CURRENT_GIT_BRANCH_IS_DIRTY='1'
	fi	
	
	local s="%{${fg[white]}%}$__CURRENT_GIT_BRANCH%{${fg_bold[red]}%}"
	
	case "$__CURRENT_GIT_BRANCH_STATUS" in
		ahead)
		s+="↑"
		;;
		diverged)
		s+="↕"
		;;
		behind)
		s+="↓"
		;;
	esac
	if [ -n "$__CURRENT_GIT_BRANCH_IS_DIRTY" ]; then
		s+=" ➔ "
	fi
 	
	printf " (%s%s)" $s "%{$reset_color%}"
	
fi
