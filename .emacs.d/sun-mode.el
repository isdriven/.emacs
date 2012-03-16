;---------------
; sun-mode.el
;
; For Script Of 
; Sunflower ( Javascript Library )
;
;---------------

(defun sun-mode()
  (interactive)
  (setq major-mode 'sunflowerscript-mode
	mode-name " Sunflower Script Mode")
  (setq sunflowerscript-local-map (make-keymap))
  (use-local-map sunflowerscript-local-map)
  (sun-run-font-lock)
)

;; define font-lock-color

(defface sun-mode-operator-face
  '((t (  :foreground "cyan1") ))
  "face for sun-mode's operator")
(defvar sun-mode-operator-face 'sun-mode-operator-face)

(defface sun-mode-comment-face
  '((t (  :foreground "chocolate1") ))
  "face for sun-mode's comment")
(defvar sun-mode-comment-face 'sun-mode-comment-face)

(defface sun-mode-title-face
  '((t (  :foreground "IndianRed1"  :box (:line-width 1 :color "RosyBrown" ) ) ))
  "face for sun-mode's title")
(defvar sun-mode-title-face 'sun-mode-title-face)

(defface sun-mode-keyword-face
  '((t (  :foreground "tomato1" ) ))
  "face for sun-mode's keyword")
(defvar sun-mode-keyword-face 'sun-mode-keyword-face)

(defface sun-mode-specialstring-face
  '((t ( :foreground "LightSkyBlue" ) ))
  "face for sun-mode's strings")
(defvar sun-mode-specialstring-face 'sun-mode-specialstring-face)

;; keywords font-lock
(setq sun-font-lock-keywords
      '(
	( "::" . sun-mode-operator-face )
	( ";.*" . sun-mode-comment-face)
	( "===.*" . sun-mode-title-face )
	; keywords
	( "preload" . sun-mode-keyword-face )
	( "preload\\-image" . sun-mode-keyword-face )
	( "destroy\\-images" . sun-mode-keyword-face )
	( "bg" . sun-mode-keyword-face )
	( "show\\-background" . sun-mode-keyword-face )
	( "show\\-filter" . sun-mode-keyword-face )
	( "remove\\-filter" . sun-mode-keyword-face )
	( "filter" . sun-mode-keyword-face )
	( "show-belt" . sun-mode-keyword-face )
	( "belt" . sun-mode-keyword-face )
	( "show-character".  sun-mode-keyword-face )	
	( "chara\\+".  sun-mode-keyword-face )
	( "remove-character".  sun-mode-keyword-face )
	( "chara\\-".  sun-mode-keyword-face )
	( "remove\\-all\\-characters".  sun-mode-keyword-face )
	( "chara\\-\\-".  sun-mode-keyword-face )
	( "script" . sun-mode-keyword-face )
	( "sc" . sun-mode-keyword-face )
	( "script\\-full" . sun-mode-keyword-face )
	( "full" . sun-mode-keyword-face )
	( "script\\-full\\-nowindow" . sun-mode-keyword-face )
	( "nav" . sun-mode-keyword-face )
	( "script\\-clear" . sun-mode-keyword-face )
	( "csc" . sun-mode-keyword-face )
	( "script\\-full\\-clear" . sun-mode-keyword-face )
	( "cfull" . sun-mode-keyword-face )
	( "clear\\-window" . sun-mode-keyword-face )
	( "cw" . sun-mode-keyword-face )
	( "reset\\-all" . sun-mode-keyword-face )
	( "remove\\-all\\-window" . sun-mode-keyword-face )
	( "show\\-selection" . sun-mode-keyword-face )
	( "select" . sun-mode-keyword-face )
	( "remove\\-selection" . sun-mode-keyword-face )
	( "show\\-prompt" . sun-mode-keyword-face )
	( "prompt" . sun-mode-keyword-face )
	( "show\\-prompt\\-pass" . sun-mode-keyword-face )
	( "prompt\\-pass" . sun-mode-keyword-face )
	( "show\\-alert" . sun-mode-keyword-face )
	( "alert" . sun-mode-keyword-face )
	( "show\\-alert\\-go" . sun-mode-keyword-face )
	( "alert\\-go" . sun-mode-keyword-face )
	( "show\\-confirm" . sun-mode-keyword-face )
	( "confirm" . sun-mode-keyword-face )
	( "set\\-menu\\-window" . sun-mode-keyword-face )	
	( "random" . sun-mode-keyword-face )
	( "blackout" . sun-mode-keyword-face )
	( "_reset" . sun-mode-keyword-face )
	( "_reset_every" . sun-mode-keyword-face )
	( "_redirect" . sun-mode-keyword-face )
	( "_val" . sun-mode-keyword-face )
	( "_go" . sun-mode-keyword-face )
	( "wait" . sun-mode-keyword-face )
	( "end" . sun-mode-keyword-face )
	( "\\[n\\]" . sun-mode-specialstring-face )
	( "@" . sun-mode-specialstring-face )
	)
)
(defun sun-run-font-lock()
  (setq font-lock-defaults '( sun-font-lock-keywords 'keywords-only t (("+" . "w"))) )
  (font-lock-fontify-buffer))

(provide 'sun-mode)  