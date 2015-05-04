(eval-when-compile    (require 'color-theme))
(defun color-theme-invaders ()
  "Color theme by baron, created 2011-03-07."
  (interactive)
  (color-theme-install
   '(color-theme-invaders
     ((background-color . "black")
      (background-mode . dark)
      (border-color . "#3e3e5e")
      (cursor-color . "green")
      (foreground-color . "white"))
     ((list-matching-lines-buffer-name-face . underline)
      (list-matching-lines-face . match))
     (default ((t (:stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "apple" :family "Monaco"))))
     (anything-header ((t (:bold t :background "grey15" :foreground "#edd400" :weight bold))))
     (bold ((t (:bold t :underline nil :weight bold))))
     ;; (bold-italic ((t (:italic t :bold t))))
     ;; ;; (bold-italic ((t (:bold t :underline nil :weight bold))))
     (bold-italic ((t (:italic t :bold t :slant italic :weight bold))))
     (border ((t (:background "#3e3e5e"))))
     (buffer-menu-buffer ((t (:bold t :weight bold))))
     (button ((t (:underline t))))
     (comint-highlight-input ((t (:italic t :bold t :slant italic :weight bold))))
     (comint-highlight-prompt ((t (:foreground "light blue"))))
     (completions-annotations ((t (:italic t :slant italic :underline nil))))
     (completions-common-part ((t (:family "Monaco" :foundry "apple" :width normal :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "white" :background "black" :stipple nil :height 120))))
     (completions-first-difference ((t (:bold t :weight bold :underline nil))))
     (cursor ((t (:background "red"))))
     (custom-button ((t (:background "grey50" :foreground "black" :box (:line-width 1 :style released-button)))))
     (custom-button-mouse ((t (:box (:line-width 1 :style released-button) :foreground "black" :background "grey60"))))
     (custom-button-mouse-pressed-unraised ((t (:foreground "black" :background "grey60"))))
     (custom-button-mouse-unraised ((t (:foreground "black" :background "grey60"))))
     (custom-button-pressed ((t (:foreground "black" :background "grey50" :box (:style pressed-button)))))
     (custom-button-unraised ((t (:background "grey50" :foreground "black"))))
     (custom-documentation ((t (:italic t :slant italic))))
     (custom-face-tag ((t (:bold t :foreground "#edd400" :weight bold :height 1.1))))
     (custom-group-tag ((t (:bold t :foreground "#edd400" :weight bold :height 1.3))))
     (custom-link ((t (:underline t :foreground "dodger blue"))))
     (custom-state-face ((t (:foreground "#729fcf"))))
     (custom-variable-button ((t (:box (:line-width 1 :style released-button) :foreground "black" :background "grey50"))))
     (custom-variable-tag ((t (:bold t :foreground "#edd400" :weight bold :height 1.1))))
     (diary-face ((t (:bold t :foreground "IndianRed" :weight bold))))
     (diredp-compressed-file-suffix ((t (:foreground "Yellow"))))
     (diredp-date-time ((t (:foreground "goldenrod1"))))
     (diredp-deletion ((t (:background "Red" :foreground "Yellow"))))
     (diredp-deletion-file-name ((t (:foreground "Red"))))
     (diredp-dir-heading ((t (:foreground "DarkOrchid1"))))
     (diredp-dir-priv ((t (:foreground "DarkRed"))))
     (diredp-display-msg ((t (:foreground "cornflower blue"))))
     (diredp-exec-priv ((t (:background "DarkBlue" :foreground "White"))))
     (diredp-executable-tag ((t (:foreground "Red"))))
     (diredp-file-name ((t (:foreground "DeepSkyBlue"))))
     (diredp-file-suffix ((t (:foreground "DarkMagenta"))))
     (diredp-flag-mark ((t (:background "Blueviolet" :foreground "Yellow"))))
     (diredp-flag-mark-line ((t (:background "Skyblue"))))
     (diredp-ignored-file-name ((t (:foreground "#00006DE06DE0"))))
     (diredp-link-priv ((t (:background "DarkOrange" :foreground "White"))))
     (diredp-no-priv ((t (:background "DarkGray" :foreground "White"))))
     (diredp-number ((t (:foreground "LightSteelBlue"))))
     (diredp-other-priv ((t (:background "DarkYellow" :foreground "White"))))
     (diredp-rare-priv ((t (:background "DarkGreen" :foreground "White"))))
     (diredp-read-priv ((t (:background "DarkRed" :foreground "White"))))
     (diredp-symlink ((t (:foreground "DarkOrange"))))
     (diredp-write-priv ((t (:background "DarkOrchid" :foreground "White"))))
     (ecb-default-highlight-face ((t (:background "#729fcf"))))
     (ecb-tag-header-face ((t (:background "#f57900"))))
     (elscreen-tab-background-face ((t (:background "gray25"))))
     (elscreen-tab-control-face ((t (:background "white"))))
     (elscreen-tab-current-screen-face ((t (:background "DodgerBlue2" :foreground "white"))))
     (elscreen-tab-other-screen-face ((t (:background "gray80" :foreground "black"))))
     (escape-glyph ((t (:foreground "MediumTurquoise"))))
     (eshell-ls-clutter-face ((t (:bold t :foreground "DimGray" :weight bold))))
     (eshell-ls-executable-face ((t (:bold t :foreground "Coral" :weight bold))))
     (eshell-ls-missing-face ((t (:bold t :foreground "black" :weight bold))))
     (eshell-ls-special-face ((t (:bold t :foreground "Gold" :weight bold))))
     (eshell-ls-symlink-face ((t (:bold t :foreground "White" :weight bold))))
     (eshell-prompt ((t (:bold t :foreground "red3" :weight bold))))
     (ess-jb-comment-face ((t (:italic t :background "#2e3436" :foreground "firebrick" :slant italic))))
     (ess-jb-h1-face ((t (:foreground "dodger blue" :slant normal :height 1.6))))
     (ess-jb-h2-face ((t (:foreground "#6ac214" :slant normal :height 1.4))))
     (ess-jb-h3-face ((t (:foreground "#edd400" :slant normal :height 1.2))))
     (ess-jb-hide-face ((t (:background "#2e3436" :foreground "#243436"))))
     (face-6 ((t (:foreground "pink"))))
     (face-7 ((t (:foreground "steelblue"))))
     (face-8 ((t (:foreground "lime green"))))
     (file-name-shadow ((t (:foreground "grey70"))))
     (fixed-pitch ((t (:family "Monospace"))))
     (font-latex-math-face ((t (:foreground "burlywood"))))
     (font-latex-sectioning-0-face ((t (:bold t :foreground "goldenrod" :weight bold :height 1.6105100000000008 :family "helv"))))
     (font-latex-sectioning-1-face ((t (:bold t :foreground "goldenrod" :weight bold :height 1.4641000000000006 :family "helv"))))
     (font-latex-sectioning-2-face ((t (:bold t :foreground "goldenrod" :weight bold :height 1.3310000000000004 :family "helv"))))
     (font-latex-sectioning-3-face ((t (:bold t :foreground "goldenrod" :weight bold :height 1.2100000000000002 :family "helv"))))
     (font-latex-sectioning-4-face ((t (:bold t :foreground "goldenrod" :weight bold :height 1.1 :family "helv"))))
     (font-latex-sectioning-5-face ((t (:bold t :foreground "goldenrod" :weight bold :family "helv"))))
     (font-latex-sedate-face ((t (:foreground "#b15161"))))
     (font-latex-subscript-face ((t (:height 0.8))))
     (font-latex-superscript-face ((t (:height 0.8))))
     (font-latex-verbatim-face ((t (:foreground "burlywood" :family "courier"))))
     (font-lock-builtin-face ((t (:foreground "RoyalBlue1"))))
     (font-lock-comment-delimiter-face ((t (:italic t :background "blue" :foreground "white" :slant italic))))
     (font-lock-comment-face ((t (:bold t :italic t :background nil :foreground "LemonChiffon" :slant italic))))
     (font-lock-constant-face ((t (:foreground "maroon1"))))
     (font-lock-doc-face ((t (:foreground "DarkOrange2"))))
     (font-lock-function-name-face ((t (:foreground "yellow1"))))
     (font-lock-keyword-face ((t (:bold t :foreground "DeepSkyBlue" :weight bold))))
     (font-lock-negation-char-face ((t (:foreground "red"))))
     (font-lock-preprocessor-face ((t (:foreground "pink"))))
     (font-lock-reference-face ((t (:bold t :foreground "#808bed" :weight bold))))
     (font-lock-regexp-grouping-backslash ((t (:bold t :weight bold :underline nil :foreground "DodgerBlue"))))
     (font-lock-regexp-grouping-construct ((t (:bold t :weight bold :underline nil :foreground "yellow"))))
     (font-lock-string-face ((t (:background "gray15" :foreground "SandyBrown"))))
     (font-lock-type-face ((t (:foreground "SpringGreen1"))))
     (font-lock-variable-name-face ((t (:foreground "SeaGreen1"))))
     (font-lock-warning-face ((t (:background "#ff0000" :foreground "#ffffff"))))
     (fp-topic-face ((t (:italic t :bold t :background "black" :foreground "lavender" :slant italic :weight bold))))
     (fringe ((t (:background "#16161b"))))
     (gnus-button ((t (:bold t :background "#191932" :box (:line-width 2 :style released-button) :weight bold))))
     (gnus-cite-attribution-face ((t (:italic t :slant italic))))
     (gnus-cite-face-1 ((t (:foreground "CornflowerBlue"))))
     (gnus-cite-face-10 ((t (:foreground "thistle1"))))
     (gnus-cite-face-11 ((t (:foreground "LightYellow1"))))
     (gnus-cite-face-2 ((t (:foreground "PaleGreen"))))
     (gnus-cite-face-3 ((t (:foreground "LightGoldenrod"))))
     (gnus-cite-face-4 ((t (:foreground "LightPink"))))
     (gnus-cite-face-5 ((t (:foreground "MediumTurquoise"))))
     (gnus-cite-face-6 ((t (:foreground "khaki"))))
     (gnus-cite-face-7 ((t (:foreground "plum"))))
     (gnus-cite-face-8 ((t (:foreground "DeepSkyBlue1"))))
     (gnus-cite-face-9 ((t (:foreground "chartreuse1"))))
     (gnus-emphasis-bold ((t (:bold t :weight bold))))
     (gnus-emphasis-bold-italic ((t (:italic t :bold t :slant italic :weight bold))))
     (gnus-emphasis-highlight-words ((t (:background "black" :foreground "yellow"))))
     (gnus-emphasis-italic ((t (:italic t :slant italic))))
     (gnus-emphasis-strikethru ((t (:strike-through t))))
     (gnus-emphasis-underline ((t (:underline t))))
     (gnus-emphasis-underline-bold ((t (:bold t :underline t :weight bold))))
     (gnus-emphasis-underline-bold-italic ((t (:italic t :bold t :underline t :slant italic :weight bold))))
     (gnus-emphasis-underline-italic ((t (:italic t :underline t :slant italic))))
     (gnus-group-mail-1 ((t (:foreground "#3BFF00" :weight normal))))
     (gnus-group-mail-1-empty ((t (:foreground "#249900"))))
     (gnus-group-mail-1-empty-face ((t (:foreground "#249900"))))
     (gnus-group-mail-1-face ((t (:foreground "#3BFF00" :weight normal))))
     (gnus-group-mail-2 ((t (:foreground "#5EFF00" :weight normal))))
     (gnus-group-mail-2-empty ((t (:foreground "#389900"))))
     (gnus-group-mail-2-empty-face ((t (:foreground "#389900"))))
     (gnus-group-mail-2-face ((t (:foreground "#5EFF00" :weight normal))))
     (gnus-group-mail-3 ((t (:foreground "#80FF00" :weight normal))))
     (gnus-group-mail-3-empty ((t (:foreground "#4D9900"))))
     (gnus-group-mail-3-empty-face ((t (:foreground "#4D9900"))))
     (gnus-group-mail-3-face ((t (:foreground "#A1FF00" :weight normal))))
     (gnus-group-mail-low ((t (:bold t :foreground "aquamarine2" :weight bold))))
     (gnus-group-mail-low-empty ((t (:foreground "aquamarine2"))))
     (gnus-group-mail-low-empty-face ((t (:foreground "aquamarine2"))))
     (gnus-group-mail-low-face ((t (:bold t :foreground "aquamarine2" :weight bold))))
     (gnus-group-news-1 ((t (:bold t :foreground "#8480FF" :weight bold))))
     (gnus-group-news-1-empty ((t (:foreground "#524DFF"))))
     (gnus-group-news-1-empty-face ((t (:foreground "#524DFF"))))
     (gnus-group-news-1-face ((t (:bold t :foreground "#8480FF" :weight bold))))
     (gnus-group-news-2 ((t (:bold t :foreground "#8088FF" :weight bold))))
     (gnus-group-news-2-empty ((t (:foreground "#4D58FF"))))
     (gnus-group-news-2-empty-face ((t (:foreground "#4D58FF"))))
     (gnus-group-news-2-face ((t (:bold t :foreground "#8088FF" :weight bold))))
     (gnus-group-news-3 ((t (:bold t :foreground "#8095FF" :weight bold))))
     (gnus-group-news-3-empty ((t (:foreground "#4D6AFF"))))
     (gnus-group-news-3-empty-face ((t (:foreground "#4D6AFF"))))
     (gnus-group-news-3-face ((t (:bold t :foreground "#8095FF" :weight bold))))
     (gnus-group-news-4 ((t (:bold t :foreground "#80A1FF" :weight bold))))
     (gnus-group-news-4-empty ((t (:foreground "#4D7CFF"))))
     (gnus-group-news-4-empty-face ((t (:foreground "#4D7CFF"))))
     (gnus-group-news-4-face ((t (:bold t :foreground "#80A1FF" :weight bold))))
     (gnus-group-news-5 ((t (:bold t :foreground "#80AEFF" :weight bold))))
     (gnus-group-news-5-empty ((t (:foreground "#4D8EFF"))))
     (gnus-group-news-5-empty-face ((t (:foreground "#4D8EFF"))))
     (gnus-group-news-5-face ((t (:bold t :foreground "#80AEFF" :weight bold))))
     (gnus-group-news-6 ((t (:bold t :foreground "#80BBFF" :weight bold))))
     (gnus-group-news-6-empty ((t (:foreground "#4DA0FF"))))
     (gnus-group-news-6-empty-face ((t (:foreground "#4DA0FF"))))
     (gnus-group-news-6-face ((t (:bold t :foreground "#80BBFF" :weight bold))))
     (gnus-group-news-low ((t (:bold t :foreground "MediumTurquoise" :weight bold))))
     (gnus-group-news-low-empty ((t (:foreground "MediumTurquoise"))))
     (gnus-group-news-low-empty-face ((t (:foreground "MediumTurquoise"))))
     (gnus-group-news-low-face ((t (:bold t :foreground "MediumTurquoise" :weight bold))))
     (gnus-header-content ((t (:italic t :foreground "DarkKhaki" :slant italic))))
     (gnus-header-content-face ((t (:italic t :foreground "DarkKhaki" :slant italic))))
     (gnus-header-from ((t (:foreground "PaleGreen1"))))
     (gnus-header-from-face ((t (:foreground "PaleGreen1"))))
     (gnus-header-name ((t (:bold t :foreground "BlanchedAlmond" :weight bold))))
     (gnus-header-name-face ((t (:bold t :foreground "BlanchedAlmond" :weight bold))))
     (gnus-header-newsgroups ((t (:italic t :foreground "yellow" :slant italic))))
     (gnus-header-newsgroups-face ((t (:italic t :foreground "yellow" :slant italic))))
     (gnus-header-subject ((t (:foreground "coral1"))))
     (gnus-header-subject-face ((t (:foreground "coral1"))))
     (gnus-signature ((t (:italic t :slant italic))))
     (gnus-signature-face ((t (:italic t :slant italic))))
     (gnus-splash ((t (:foreground "#cccccc"))))
     (gnus-splash-face ((t (:foreground "#cccccc"))))
     (gnus-summary-cancelled ((t (:background "black" :foreground "yellow"))))
     (gnus-summary-cancelled-face ((t (:background "black" :foreground "yellow"))))
     (gnus-summary-high-ancient ((t (:bold t :foreground "CornflowerBlue" :weight bold))))
     (gnus-summary-high-ancient-face ((t (:bold t :foreground "CornflowerBlue" :weight bold))))
     (gnus-summary-high-read ((t (:bold t :foreground "grey60" :weight bold))))
     (gnus-summary-high-read-face ((t (:bold t :foreground "grey60" :weight bold))))
     (gnus-summary-high-ticked ((t (:bold t :foreground "RosyBrown" :weight bold))))
     (gnus-summary-high-ticked-face ((t (:bold t :foreground "RosyBrown" :weight bold))))
     (gnus-summary-high-undownloaded ((t (:bold t :foreground "ivory3" :weight bold))))
     (gnus-summary-high-unread ((t (:bold t :foreground "PaleGreen" :weight bold))))
     (gnus-summary-high-unread-face ((t (:bold t :foreground "PaleGreen" :weight bold))))
     (gnus-summary-low-ancien-facet ((t (:italic t :foreground "LightSteelBlue" :slant italic))))
     (gnus-summary-low-ancient ((t (:italic t :foreground "LightSteelBlue" :slant italic))))
     (gnus-summary-low-ancient-face ((t (:italic t :foreground "lime green" :slant italic))))
     (gnus-summary-low-read ((t (:italic t :foreground "LightSlateGray" :slant italic))))
     (gnus-summary-low-read-face ((t (:italic t :foreground "LightSlateGray" :slant italic))))
     (gnus-summary-low-ticked ((t (:italic t :foreground "pink" :slant italic))))
     (gnus-summary-low-ticked-face ((t (:italic t :foreground "pink" :slant italic))))
     (gnus-summary-low-undownloaded ((t (:italic t :foreground "grey75" :slant italic :weight normal))))
     (gnus-summary-low-unread ((t (:italic t :foreground "MediumSeaGreen" :slant italic))))
     (gnus-summary-low-unread-face ((t (:italic t :foreground "MediumSeaGreen" :slant italic))))
     (gnus-summary-normal-ancient ((t (:foreground "SkyBlue"))))
     (gnus-summary-normal-ancient-face ((t (:foreground "SkyBlue"))))
     (gnus-summary-normal-read ((t (:foreground "grey50"))))
     (gnus-summary-normal-read-face ((t (:foreground "grey50"))))
     (gnus-summary-normal-ticked ((t (:foreground "LightSalmon"))))
     (gnus-summary-normal-ticked-face ((t (:foreground "LightSalmon"))))
     (gnus-summary-normal-undownloaded ((t (:foreground "LightGray" :weight normal))))
     (gnus-summary-normal-unread ((t (:foreground "YellowGreen"))))
     (gnus-summary-normal-unread-face ((t (:foreground "YellowGreen"))))
     (gnus-summary-root-face ((t (:bold t :foreground "Red" :weight bold))))
     (gnus-summary-selected ((t (:foreground "LemonChiffon" :underline t))))
     (gnus-summary-selected-face ((t (:foreground "LemonChiffon" :underline t))))
     (gnus-topic-face ((t (:italic t :bold t :background "black" :foreground "lavender" :slant italic :weight bold))))
     (gnus-user-agent-bad-face ((t (:bold t :background "black" :foreground "red" :weight bold))))
     (gnus-user-agent-good-face ((t (:background "black" :foreground "green"))))
     (gnus-user-agent-unknown-face ((t (:bold t :background "black" :foreground "orange" :weight bold))))
     (gnus-x-face ((t (:background "white" :foreground "black"))))
     (header-line ((t (:bold t :weight bold :box (:line-width 1 :color nil :style released-button) :background "grey20" :foreground "grey90" :box nil))))
     (help-argument-name ((t (:italic t :slant italic :underline nil))))
     (highlight ((t (:background "#404040"))))
     (hl-line ((t (:background "#141423"))))
     (info-xref ((t (:foreground "SpringGreen1"))))
     (info-xref-visited ((t (:foreground "yellow"))))
     (isearch ((t (:bold t :background "#cd8b60" :foreground "#303030" :weight bold))))
     (isearch-fail ((t (:background "red4"))))
     (italic ((t (:italic t :underline nil :slant italic))))
     (lazy-highlight ((t (:background "#005bd4"))))
     (link ((t (:foreground "dodger blue" :underline t))))
     (link-visited ((t (:underline t :foreground "violet"))))
     (magit-diff-add ((t (:foreground "#729fcf"))))
     (magit-header ((t (:foreground "#edd400"))))
     (magit-item-highlight ((t (:bold t :weight extra-bold))))
     (match ((t (:bold t :underline t :background "white" :foreground "red1" :weight bold))))
     (menu ((t (nil))))
     (message-cited-text ((t (:foreground "#edd400"))))
     (message-header-cc ((t (:foreground "white"))))
     (message-header-name-face ((t (:foreground "tomato"))))
     (message-header-newsgroups-face ((t (:italic t :bold t :foreground "LightSkyBlue3" :slant italic :weight bold))))
     (message-header-other-face ((t (:foreground "LightSkyBlue3"))))
     (message-header-subject ((t (:foreground "white"))))
     (message-header-to ((t (:foreground "white"))))
     (message-header-xheader-face ((t (:foreground "DodgerBlue3"))))
     (minibuffer-prompt ((t (:bold t :foreground "#708090" :weight bold))))
     (mode-line ((t (:bold t :background "SteelBlue" :foreground "Black" :box (:line-width 1 :color nil :style released-button) :weight bold))))
     (mode-line-buffer-id ((t (:bold t :background "RoyalBlue" :foreground "OldLace" :weight bold))))
     (mode-line-emphasis ((t (:bold t :weight bold))))
     (mode-line-highlight ((t (:background "White" :box (:line-width 2 :color "grey40" :style released-button)))))
     (mode-line-inactive ((t (:background "chocolate3" :foreground "White"))))
     (mouse ((t (:background "#8ae234"))))
     (mumamo-background-chunk-major ((t (:background nil))))
     (mumamo-background-chunk-submode1 ((t (:background nil))))
     (my-gnus-direct-fup-face ((t (:bold t :background "NavyBlue" :foreground "#70fc70" :weight bold))))
     (my-gnus-indirect-fup-face ((t (:bold t :background "#092109" :foreground "#7fff7f" :weight bold))))
     (my-gnus-own-posting-face ((t (:bold t :background "#210909" :foreground "chartreuse3" :weight bold))))
     (my-group-face-2 ((t (:bold t :foreground "DarkSeaGreen1" :weight bold))))
     (my-group-face-3 ((t (:bold t :foreground "Green1" :weight bold))))
     (my-group-face-4 ((t (:bold t :foreground "LightSteelBlue" :weight bold))))
     (my-group-face-5 ((t (:bold t :foreground "beige" :weight bold))))
     (my-group-mail-unread-crit-1 ((t (:bold t :foreground "#99FFAA" :weight bold))))
     (my-group-mail-unread-crit-2 ((t (:foreground "#99FF9C" :weight normal))))
     (my-group-mail-unread-crit-3 ((t (:foreground "#A3FF99" :weight normal))))
     (my-group-mail-unread-high-1 ((t (:bold t :foreground "#B1FF99" :weight bold))))
     (my-group-mail-unread-high-2 ((t (:foreground "#BEFF99" :weight normal))))
     (my-group-mail-unread-high-3 ((t (:foreground "#CCFF99" :weight normal))))
     (my-group-mail-unread-mod-1 ((t (:bold t :foreground "#DAFF99" :weight bold))))
     (my-group-mail-unread-mod-2 ((t (:foreground "#E7FF99" :weight normal))))
     (my-group-mail-unread-mod-3 ((t (:foreground "#F5FF99" :weight normal))))
     (my-group-news-unread-crit-3 ((t (:bold t :foreground "#BFB3FF" :weight bold))))
     (my-group-news-unread-crit-4 ((t (:bold t :foreground "#BAB3FF" :weight bold))))
     (my-group-news-unread-crit-5 ((t (:foreground "#B5B3FF" :weight normal))))
     (my-group-news-unread-crit-6 ((t (:foreground "#B3B5FF" :weight normal))))
     (my-group-news-unread-high-3 ((t (:bold t :foreground "#B3BAFF" :weight bold))))
     (my-group-news-unread-high-4 ((t (:bold t :foreground "#B3BFFF" :weight bold))))
     (my-group-news-unread-high-5 ((t (:foreground "#B3C4FF" :weight normal))))
     (my-group-news-unread-high-6 ((t (:foreground "#B3C9FF" :weight normal))))
     (my-group-news-unread-mod-3 ((t (:bold t :foreground "#B3CFFF" :weight bold))))
     (my-group-news-unread-mod-4 ((t (:bold t :foreground "#B3D4FF" :weight bold))))
     (my-group-news-unread-mod-5 ((t (:foreground "#B3D9FF" :weight normal))))
     (my-group-news-unread-mod-6 ((t (:foreground "#B3DEFF" :weight normal))))
     (navi2ch-article-url-face ((t (:foreground "#B3DEFF" :weight normal))))
     (next-error ((t (:background "#610d00"))))
     (nobreak-space ((t (:foreground "PaleTurquoise1" :underline t))))
     (ns-marked-text-face ((t (:underline t))))
     (ns-working-text-face ((t (:underline "gray20"))))
     (org-agenda-clocking ((t (:background "red4" :foreground "white"))))
     (org-agenda-date ((t (:foreground "LightSkyBlue"))))
     (org-agenda-date-today ((t (:bold t :foreground "#edd400" :weight bold))))
     (org-agenda-date-weekend ((t (:bold t :foreground "LightSkyBlue" :weight bold))))
     (org-agenda-dimmed-todo-face ((t (:bold t :foreground "white" :weight bold))))
     (org-agenda-done ((t (:foreground "DodgerBlue1"))))
     (org-agenda-restriction-lock ((t (:background "skyblue4"))))
     (org-agenda-structure ((t (:foreground "LightSkyBlue"))))
     (org-archived ((t (:foreground "grey70"))))
     (org-block ((t (:foreground "#bbbbbc"))))
     (org-code ((t (:foreground "grey70"))))
     (org-column ((t (:background "grey30" :strike-through nil :underline nil :slant normal :weight normal :height 81 :foundry "unknown" :family "DejaVu Sans Mono"))))
     (org-column-title ((t (:bold t :background "grey30" :underline t :weight bold))))
     (org-date ((t (:foreground "CadetBlue2" :underline t))))
     (org-done ((t (:bold t :foreground "Green" :weight bold))))
     (org-drawer ((t (:foreground "LightSkyBlue"))))
     (org-ellipsis ((t (:foreground "LightGoldenrod" :underline t))))
     (org-footnote ((t (:foreground "magenta3" :underline t))))
     (org-formula ((t (:foreground "chocolate1"))))
     (org-headline-done ((t (:foreground "LightSalmon"))))
     (org-hide ((t (:foreground "black"))))
     (org-latex-and-export-specials ((t (:foreground "burlywood"))))
     (org-level-1 ((t (:bold t :foreground "DodgerBlue1" :height 1.7))))
     (org-level-2 ((t (:bold nil :foreground "LightGoldenrod" :height 1.5))))
     (org-level-3 ((t (:bold t :foreground "SpringGreen1" :height 1.2))))
     (org-level-4 ((t (:bold nil :foreground "chocolate1" :height 1.1))))
     (org-level-5 ((t (:foreground "PaleGreen"))))
     (org-level-6 ((t (:foreground "Aquamarine"))))
     (org-level-7 ((t (:foreground "LightSteelBlue"))))
     (org-level-8 ((t (:foreground "LightSalmon"))))
     (org-link ((t (:foreground "DeepSkyBlue1" :underline t))))
     (org-property-value ((t (nil))))
     (org-quote ((t (:italic t :foreground "#bbbbbc" :slant italic))))
     (org-scheduled-previously ((t (:foreground "red" :weight bold))))
     ;; (org-scheduled-today ((t (:foreground "PaleGreen"))))
     (org-scheduled-today ((t (:bold t :foreground "yellow"))))
     (org-special-keyword ((t (:foreground "DodgerBlue1"))))
     (org-sexp-date ((t (:foreground "OliveDrab1"))))
     (org-table ((t (:foreground "LightSkyBlue"))))
     (org-tag ((t (:bold t :weight bold))))
     (org-target ((t (:underline t))))
     (org-time-grid ((t (:foreground "LightGoldenrod"))))
     (org-todo ((t (:bold t :background "Red" :foreground "White" :weight bold))))
     (org-upcoming-deadline ((t (:foreground "chocolate1"))))
     (org-verbatim ((t (:foreground "grey70" :underline t))))
     (org-verse ((t (:italic t :foreground "#bbbbbc" :slant italic))))
     (org-warning ((t (:bold t  :background "Red" :foreground "White" :weight bold))))
     (outline-1 ((t (:foreground "DodgerBlue1"))))
     (outline-2 ((t (:foreground "goldenrod1"))))
     (outline-3 ((t (:foreground "DarkGoldenrod1"))))
     (outline-4 ((t (:foreground "chocolate1"))))
     (outline-5 ((t (:foreground "PaleGreen"))))
     (outline-6 ((t (:foreground "DarkSeaGreen1"))))
     (outline-7 ((t (:foreground "LightSteelBlue"))))
     (outline-8 ((t (:foreground "NavajoWhite1"))))
     (paren-face-match ((t (:background "steelblue"))))
     (paren-face-mismatch ((t (:background "purple" :foreground "white"))))
     (paren-face-no-match ((t (:background "yellow" :foreground "black"))))
     (query-replace ((t (:bold t :weight bold :foreground "#303030" :background "#cd8b60"))))
     (rainbow-delimiters-depth-1-face ((t (:foreground "white"))))
     (rainbow-delimiters-depth-2-face ((t (:foreground "orange1"))))
     (rainbow-delimiters-depth-3-face ((t (:foreground "yellow1"))))
     (rainbow-delimiters-depth-4-face ((t (:foreground "greenyellow"))))
     (rainbow-delimiters-depth-5-face ((t (:foreground "green1"))))
     (rainbow-delimiters-depth-6-face ((t (:foreground "SpringGreen1"))))
     (rainbow-delimiters-depth-7-face ((t (:foreground "cyan1"))))
     (rainbow-delimiters-depth-8-face ((t (:foreground "slateblue1"))))
     (rainbow-delimiters-depth-9-face ((t (:foreground "magenta1"))))
     (rainbow-delimiters-depth-10-face ((t (:foreground "purple"))))
     (rainbow-delimiters-depth-11-face ((t (:foreground "DodgerBlue1"))))
     (rainbow-delimiters-depth-12-face ((t (:foreground "red"))))
     (region ((t (:background "grey17"))))
     (scroll-bar ((t (nil))))
     (secondary-selection ((t (:background "SkyBlue4"))))
     (sense-region-offset-face ((t (:background "lightgoldenrod2"))))
     (sense-region-rectangle-face ((t (:background "lightgoldenrod2"))))
     (sense-region-region-face ((t (:background "lightgoldenrod2"))))
     (sense-region-selection-base-face ((t (:background "#666688"))))
     (sense-region-selection-highlight-face ((t (:background "darkseagreen2"))))
     (shadow ((t (:foreground "grey70"))))
     (show-paren-match-face ((t (:background "orangered2"))))
     (show-paren-mismatch-face ((t (:background "#ad7fa8" :foreground "#2e3436"))))
     (tool-bar ((t (:background "grey75" :foreground "black" :box (:line-width 1 :style released-button)))))
     (tool-tips ((t (:family "Sans Serif" :background "lightyellow" :foreground "black"))))
     (tooltip ((t (:family "Sans Serif" :background "lightyellow" :foreground "black"))))
     (trailing-whitespace ((t (:background "red1"))))
     (twittering-uri-face ((t (:foreground "DeepSkyBlue1" :background nil))))
     (twittering-username-face ((t (:foreground "yellow1" :background nil))))
     (underline ((t (:underline t))))
     (variable-pitch ((t (:family "Sans Serif"))))
     (vertical-border ((t (nil))))
     (w3m-anchor ((t (:foreground "DeepSkyBlue1"))))
     (w3m-anchor-face ((t (:foreground "SkyBlue1" :underline t))))
     (w3m-arrived-anchor ((t (:foreground "purple1"))))
     (w3m-arrived-anchor-face ((t (:foreground "cadet blue" :underline t))))
     (w3m-bitmap-image-face ((t (:foreground "gray4" :background "green"))))
     (w3m-bold ((t (:weight bold :foreground "medium sea green"))))
     (w3m-bold-face ((t (:foreground "DeepSkyBlue1" :bold t))))
     (w3m-current-anchor ((t (:weight bold :underline t :foreground "SteelBlue1"))))
     (w3m-current-anchor-face ((t (:foreground "light sea green" :bold t :underline t))))
     (w3m-form ((t (:underline t :foreground "tan1"))))
     (w3m-form-button-face ((t (:background "lightgray" :foreground "black"))))
     (w3m-form-button-face ((t (:weight bold :underline t :foreground "gray4" :background "light grey"))))
     (w3m-form-button-mouse-face ((t (:background "orange"))))
     (w3m-form-button-pressed-face ((t (:background "yellow"))))
     (w3m-form-face ((t (:foreground "gray4" :background "light gray" :bold t :box (:line-width 1 :style released-button)))))
     (w3m-header-line-location-content-face ((t (:foreground "purple2"))))
     (w3m-header-line-location-title-face ((t (:foreground "cadet blue"))))
     (w3m-history-current-url-face ((t (:foreground "LightSkyBlue" :background "SkyBlue4"))))
     (w3m-image-face ((t (:weight bold :foreground "DarkSeaGreen2"))))
     (w3m-image-anchor-face ((t (:weight bold :foreground "white" :background "DodgerBlue3"))))
     (w3m-link-numbering-face ((t (:foreground "medium sea green" :bold t))))
     (w3m-linknum-match ((t (:foreground "white" :background "ForestGreen"))))
     (w3m-strike-through-face ((t (:strike-through t))))
     (w3m-tab-background-face ((t (:foreground "white" :background "#21364B"))))
     (w3m-tab-selected-face ((t (:foreground "black" :background "Gray85" :box (:line-width 1 :style nil)))))
     (w3m-tab-selected-retrieving-face ((t (:background "gray85" :foreground "white" :box (:line-width -1 :style nil)))))
     (w3m-tab-unselected-face ((t (:foreground "gray20" :background "gray70" :box (:line-width 1 :style nil)))))
     (w3m-tab-unselected-retrieving-face ((t (:foreground "white" :background "gray50" :box (:line-width -1 :style nil)))))
     (w3m-underline-face ((t (:underline t))))
     (widget-button ((t (:bold t :weight bold))))
     (widget-button-pressed ((t (:foreground "red1"))))
     (widget-documentation ((t (:foreground "lime green"))))
     (widget-field ((t (:background "gray30" :foreground "orange"))))
     (widget-inactive ((t (:foreground "grey70"))))
     (widget-mouse-face ((t (:bold t :background "brown4" :foreground "white" :weight bold))))
     (widget-single-line-field ((t (:background "gray30" :foreground "orange"))))
     )))
(add-to-list 'color-themes '(color-theme-invaders  "invaders color theme" "Sam Baron"))
(provide 'color-theme-invaders)
