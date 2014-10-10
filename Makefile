#
# From Brad's dotfiles Make script
# https://github.com/bradleywright/dotfiles/blob/master/Makefile
#

SOURCE		:= $(CURDIR)
TARGET		:= $(HOME)
FILES		:= zshrc gitconfig gitignore_global aliases vimrc vim python_conf zsh git-flow-completion.zsh

UNAME		:= $(shell uname)

.PHONY: git_submodule install clean

all: clean install

git_submodule:
	git submodule update --init

install_dotfiles:
	@for f in $(FILES); do \
		ln -sf $(SOURCE)/$$f $(TARGET)/.$$f; \
	done

clean_dotfiles:
	@-for f in $(FILES); do \
		unlink $(TARGET)/.$$f; \
	done

install: install_dotfiles

clean: clean_dotfiles
