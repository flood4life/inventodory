#!/usr/bin/env bash

set -eo pipefail

web-server() {
    rm -f tmp/pids/server.pid
    bin/rails db:create db:migrate
    bin/rails server -b 0.0.0.0
}

webpack-server() {
    bin/webpack-dev-server
}

main() {
    case "$1" in
        web-server)
            web-server
            ;;
        webpack-server)
            webpack-server
            ;;
        *)
            echo "Unrecognized command '$1'"
            exit 1
            ;;
    esac
}

main "$@"
