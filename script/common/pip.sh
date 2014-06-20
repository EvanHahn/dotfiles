#!/bin/bash

function pipget() {
	sudo pip install --upgrade "${@}" -q
}

pipget pip
pipget virtualenv
