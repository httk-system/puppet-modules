#!/bin/bash

puppet apply ./helpful_user_defaults.pp --modulepath "$(dirname -- "$BASH_SOURCE"; )/..:$(dirname -- "$BASH_SOURCE"; )/../../external"
