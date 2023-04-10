if [[ "$(makoctl mode| tail -n 1)" == "dnd" ]]; then makoctl mode -r dnd;else makoctl mode -a dnd; fi
