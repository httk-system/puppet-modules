#!/bin/bash

puppet apply "$(dirname -- "$BASH_SOURCE"; )/helpful_user_defaults.pp" --modulepath "$(dirname -- "$BASH_SOURCE"; )/..:$(dirname -- "$BASH_SOURCE"; )/../../external"
