(fset 'add-table-bar
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("|||" 0 "%d")) arg)))
