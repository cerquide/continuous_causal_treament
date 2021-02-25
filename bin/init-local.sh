#!/usr/bin/env bash
if [[ ! -d .venv ]]; then
    python3 -m venv .venv
fi
source .venv/bin/activate
pip install -U pip
pip install -r requirements.txt
if [[ ! -d $HOME/.cmdstan ]]; then
    install_cmdstan
fi
export PYTHONPATH=$PYTHONPATH:${PWD}/src

