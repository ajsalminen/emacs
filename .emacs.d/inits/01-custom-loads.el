;; This file is for libraries that should be loaded on their own, relatively early

;; sequential command is a handy library that remaps upcase to apply backward
;; and C-a to cycle through positions upon repeated presses (hence sequential)
(require 'sequential-command-config)
(sequential-command-setup-keys)
