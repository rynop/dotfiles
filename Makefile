DOTFILES := $(CURDIR)
SPOONS_DIR := osx/.hammerspoon/Spoons

.PHONY: init osx linux universal homebrew hammerspoon-pre-dots

init: homebrew

osx: universal-dots hammerspoon-pre-dots osx-dots

osx-dots:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" osx

linux: universal-dots linux-dots

linux-dots:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" linux

universal-dots:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" universal

hammerspoon-pre-dots:
	for url in $(shell cat extra/hammerspoon/spoon-zip-urls); do \
		curl -sSL -o $(SPOONS_DIR)/$$(basename $$url) $$url && \
		unzip -qo $(SPOONS_DIR)/$$(basename $$url) -d $(SPOONS_DIR)/ && \
		rm $(SPOONS_DIR)/$$(basename $$url); \
	done

homebrew:
	brew bundle --file="$(DOTFILES)/extra/homebrew/Brewfile"
	brew cleanup
	brew doctor
