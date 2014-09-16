#
# From Brad's dotfiles Make script
# https://github.com/bradleywright/dotfiles/blob/master/Makefile
#

SOURCE		:= $(CURDIR)
TARGET		:= $(HOME)
FILES		:= bashrc bash_profile gitconfig gitignore_global aliases profile vimrc vim python_conf

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
