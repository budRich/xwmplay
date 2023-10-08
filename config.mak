NAME         := xwmplay
CREATED      := 2023-09-16
UPDATED      := 2023-10-08
VERSION      := 0.1.5
DESCRIPTION  := spawn a command in a nested X(ephyr) session
AUTHOR       := budRich
CONTACT      := https://github.com/budrich/i3play
ORGANISATION := budlabs
USAGE        := $(NAME) [OPTIONS] -- COMMAND
LICENSE      := 0BSD

MONOLITH     := _$(NAME)

.PHONY: install uninstall readme

readme: README.md

installed_script    := $(DESTDIR)$(PREFIX)/bin/$(NAME)
installed_license   := $(DESTDIR)$(PREFIX)/share/licenses/$(NAME)/LICENSE

install: all
	@[[ -f LICENSE ]] && {
		echo "install -Dm644 LICENSE $(installed_license)"
		install -Dm644 LICENSE $(installed_license)
	}

	echo "install -Dm755 $(MONOLITH) $(installed_script)"
	install -Dm755 $(MONOLITH) $(installed_script)

uninstall:
	@for f in $(installed_script) $(installed_license); do
		[[ -f $$f ]] || continue
		echo "rm $$f"
		rm "$$f"
	done


README.md: $(CACHE_DIR)/help_table.txt $(DOCS_DIR)/readme_description.md $(DOCS_DIR)/readme_installation.md $(CACHE_DIR)/copyright.txt
	@$(info making $@)
	{
	  cat $(DOCS_DIR)/readme_description.md
	  echo
	  cat $(DOCS_DIR)/readme_installation.md
	  echo
	  echo "## usage"
	  echo
	  echo '```'
	  echo $(USAGE)
	  cat $(CACHE_DIR)/help_table.txt
	  echo '```'
	  echo
	  echo "## copyright"
	  echo
	  cat $(CACHE_DIR)/copyright.txt
	} > $@

