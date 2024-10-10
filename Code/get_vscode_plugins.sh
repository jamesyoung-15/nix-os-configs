#!/usr/bin/env bash

while read line; do code --install-extension "$line"; done < vscode_plugin_list.txt