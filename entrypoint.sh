#!/bin/bash
set -e
set -x


# Define help message
show_help() {
    echo """
    Commands
    test 	  : runs tests
    pip_freeze    : freeze pip dependencies and write to requirements.txt
    """
}



pip_freeze() {
    rm -rf /tmp/env
    virtualenv -p python /tmp/env/
    /tmp/env/bin/pip install -f /code/dependencies -r ./primary-requirements.txt --upgrade
    set +x
    echo -e "###\n# frozen requirements DO NOT CHANGE\n# To update this update 'primary-requirements.txt' then run ./entrypoint.sh pip_freeze\n###" | tee requirements.txt
    /tmp/env/bin/pip freeze --local | grep -v appdir | tee -a requirements.txt
}

case "$1" in
    test)
        cd /code/
        source /var/env/bin/activate
	py.test tests/
        cat << "EOF"
  ____                 _     _       _     _
 / ___| ___   ___   __| |   (_) ___ | |__ | |
| |  _ / _ \ / _ \ / _` |   | |/ _ \| '_ \| |
| |_| | (_) | (_) | (_| |   | | (_) | |_) |_|
 \____|\___/ \___/ \__,_|  _/ |\___/|_.__/(_)
                          |__/
EOF
    ;;
    pip_freeze )
        pip_freeze
    ;;
    bash )
	# slightly redundent but is nice when we need to set up the
	# environment all in one place in the future.
        bash "${@:2}"
    ;;
    help)
        show_help
    ;;
    *)
        show_help
    ;;
esac
