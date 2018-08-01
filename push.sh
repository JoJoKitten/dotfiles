#!/bin/sh
# This script adds the config.yaml file and the dotfiles folder to git,
# commits and pushes it

cd ~/dotfiles
git add config.yaml dotfiles
git commit
git push

