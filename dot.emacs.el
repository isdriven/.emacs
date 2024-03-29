;;-----
; Ippei Sato 's dot.Emacs
;    version : 23.3
;    compile : Max OS X
;    update  : 2011.11
;;-----

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; GENERAL ;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;
;;;; valriables
;;;;
(defvar my-indent-settings nil "use tabs for indent?")

;;;;
;;;; ENCODING
;;;;
(set-language-environment "Japanese" ) (set-default-coding-systems 'utf-8-unix )
(set-terminal-coding-system 'utf-8-unix ) (set-buffer-file-coding-system 'utf-8-unix ) 
(prefer-coding-system 'utf-8-unix )

;;;;
;;;; SKINS 
;;;;
(global-font-lock-mode t)
; background and font color
(add-to-list 'default-frame-alist '(foreground-color ."white"))
(add-to-list 'default-frame-alist '(background-color ."black"))
; frame's size and position
(setq initial-frame-alist '((width . 230)(height . 50)(top . 10)(left . 2)))
; cursor's type
(add-to-list 'default-frame-alist '(cursor-type,'box))
; window opacisty
(set-frame-parameter nil 'alpha 80)
; title
(setq frame-title-format (format "%%f- Ippei's Emacs" (system-name)))
; mode-line's infomation
(line-number-mode t) (column-number-mode t)
(setq initial-scratch-message nil)
; user space for indent, indent is 4 
(setq indent-tabs-mode nil) (setq tab-width 4 )
; display
(display-time-mode t)
; turn off
(tool-bar-mode 0) (setq inhibit-startup-message t) 
(setq ring-bell-function 'ignore) 
(setq next-line-add-newlines nil)
; mode-line color and region color
(custom-set-faces
 ;; font
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "apple" :family "Menlo"))))
 ;; mode-line
 '(mode-line ((t (:foreground "skyblue" :background "#222222" :box (:line-width 1 :color nil :style released-button)))))
 ;; region
 '(region ((t (:foreground "black" :background "skyblue")))))
;; highlight line
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "gray10"
 :underline "gray24"))
    (((class color)
      (background light))
     (:background "ForestGreen"
 :underline nil))
    (t ()))
  "*Face useed by hl-line")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)



;;;;
;;;; BASIC FUNCTIONS MODE
;;;;
; region color and buffer selection
(transient-mark-mode t) (iswitchb-mode t)
; make strength parent brace
(show-paren-mode t) 
; no auto-save
(setq auto-save-default nil)

;;;;
;;;; BASIC ADDITIONAL FUNCTIONS
;;;;
; no backup files
(setq backup-enable-predicate
      (lambda (name) nil))
; good buffer selection
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
; no kill without confirm
(defadvice kill-new (before ys:no-kill-new-duplicaties activate )
  (setq kill-ring (delete (ad-get-arg 0 ) kill-ring )))
;; ask before kill-emacs
(add-hook 'kill-emacs-query-functions
 (lambda ()(y-or-n-p "本当に終了する? ")))

;;;;
;;;; LOAD-PATH
;;;;
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/auto-complete/")
(add-to-list 'load-path "~/.emacs.d/yasnippet-0.6.1c/")
(add-to-list 'load-path "~/.emacs.d/auto-install/")

;;;;
;;;; ADJUST TO EMACS 22
;;;;
(set-face-bold-p 'font-lock-warning-face nil)
(setq split-width-threshold nil)

;;;;
;;;; JAPANESE FONT SET
;;;;
(when (>= emacs-major-version 23)
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0208
  '( "osaka" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0212
  '("osaka" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'jisx0201
  '("osaka" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'mule-unicode-0100-24ff
  '("Menlo" . "iso10646-1"))
)


;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; LANGUAGE MODE ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;
;;;; FUNCTIONS
;;;;
(defun indent-refine ()
  (interactive)
  (c-set-offset 'case-label '+)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-cont 0)
  (c-set-offset 'arglist-cont-nonempty 0)
  (c-set-offset 'arglist-close 0))
  
;;;;
;;;; PHP-MODE
;;;;
(require 'php-mode)
(add-hook 'php-mode-hook
 (lambda ()
   (setq c-basic-offset 4)
   (setq tab-width 4)
   (indent-refine)
   (setq indent-tabs-mode my-indent-settings)
   )
 )
(add-hook 'php-mode-hook 'hs-minor-mode)
(autoload 'php-mode "php-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.php" . php-mode))

;;;- hs-mode for php
(define-key php-mode-map (kbd "C-c C-o") 'hs-toggle-hiding)
(define-key php-mode-map (kbd "C-c C-f") 'hs-toggle)
(defvar my-hs-state-hide nil)

(defun hs-toggle()
  (interactive)
  (hs-toggle-mode)
  (if my-hs-state-hide 
      (progn (hs-show-all) (setq my-hs-state-hide nil))
    (progn (hs-hide-array)(hs-hide-function)(setq my-hs-state-hide t))))

(defun hs-toggle-mode()
  (if (not hs-minor-mode)
      (hs-minor-mode)))

(defun hs-hide-function()
  (save-excursion
    (beginning-of-buffer)
    (while (re-search-forward "function.*?(.*?)" nil t)
      (if (search-forward "{" nil t )
	  (hs-hide-block)))))

(defun hs-hide-array()
  (save-excursion
    (beginning-of-buffer)
    (while (re-search-forward "array(" nil t)
      (hs-hide-block))))
;;;;
;;;; js2-mode
;;;;
(defun js2-indent-and-back-to-indentation()
  (interactive)
  (indent-for-tab-command)
  (let (( point-of-indentation (save-excursion (back-to-indentation) (point) ) ) )
    (skip-chars-forward "/s " point-of-indentation)))

(require 'js2-mode)
(add-hook 'js2-mode-hook
 (lambda ()
   (setq indent-tabs-mode my-indent-settings)
   (setq tab-width 4)
   (yas/minor-mode)
   (setq c-basic-offset 4)))
(setq js2-mirror-mode nil
      js2-auto-indent-p t
      ; no errors 
      js2-mode-show-parse-errors nil
      js2-mode-show-strict-warnings nil
      js2-strict-trailing-comma-warning nil
      js2-strict-missing-semi-warning nil
      js2-strict-inconsistent-return-warning nil
      js2-missing-semi-one-line-override t
      js2-highlight-external-variables nil
      js2-highlight-level 3 
      )
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))
(define-key js2-mode-map [tab] 'js2-indent-and-back-to-indentation)

;;;;
;;;; C-MODE
;;;;
(add-hook 'c-mode-hook
 (lambda ()
   (setq tab-width 4)
   (setq c-basic-offset 4)
   (setq indent-tabs-mode my-indent-settings)
   (indent-refine)))

;;;;
;;;; CPP-MODE
;;;;
(add-hook 'c++-mode-hook
 (lambda ()
   (setq tab-width 4)
   (setq c-basic-offset 4)
   (setq indent-tabs-mode my-indent-settings)
   (indent-refine)))

;;;;
;;;; OBJECTIVE-C MODE
;;;;
(add-hook 'objc-mode-hook
 (lambda ()
   (setq c-basic-offset 4)
   (setq tab-width 4)
   (indent-refine)
   (setq indent-tabs-mode my-indent-settings)
   )
 )

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; EXTENSIONS ;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;
;;;; linum
;;;;
(require 'linum)
(global-linum-mode t)
(setq linum-format "%5d ")

;;;;
;;;; tramp
;;;;
(require 'tramp)

;;;;
;;;; proxy
;;;;
(add-to-list 'tramp-default-proxies-alist
    '( "teki"  "sato"  "/ssh:sato@spdev:" ) )
(add-to-list 'tramp-default-proxies-alist
             '("plgl" nil "/ssh:sato@spdev:"))

;;;;
;;;; anything
;;;;
(require 'anything-startup)
(anything-read-string-mode -1)
(define-key anything-map "\C-p" 'anything-previous-line)
(define-key anything-map "\C-n" 'anything-next-line)
(define-key anything-map "\C-v" 'anything-next-source)
(define-key anything-map "\M-v" 'anything-previous-source)
(global-set-key (kbd "C-:") 'anything-show-kill-ring)
(global-set-key (kbd "C-c C-x") 'anything)

;;;- anything source
(defvar anything-c-source-ipsleoz.com-source
  '((name . "ipsleoz.com-source" )
    (candidates-file . "~/.file-source" )
    (action . (lambda (selection) (find-file (format "/ssh:root@ipsleoz.com#3843:/www/%s" selection))))
    ))

(defun ipsleoz:anything ()
  (interactive)
  (anything-other-buffer
    '( anything-c-source-ipsleoz.com-source )
    "*access:ipsleoz.com*"))

(global-set-key (kbd "C-t") 'ipsleoz:anything)
(define-key dired-mode-map (kbd "C-t") 'ipsleoz:anything)


;;;;
;;;; auto-complete
;;;;
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete//ac-dict")
(ac-config-default)
(define-key ac-complete-mode-map [tab] 'ac-next)
(setq ac-auto-start 3)

;;;;
;;;; yasippet
;;;;
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet-0.6.1c/snippets")

;;;;
;;;; color-moccur
;;;;
(require 'color-moccur)


;;;;
;;;; moccur-edit
;;;;
(require 'moccur-edit)

;;;;
;;;; eshell
;;;;
(add-hook 'eshell-mode-hook
      (lambda ()
        (setq indent-tabs-mode t)
        ))

(defun eshell/ccr ()
  "Clear the current buffer, leaving one prompt at the top."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (define-key eshell-mode-map (kbd "C-a") 'eshell-bol)
    (define-key eshell-mode-map (kbd "C-r") 'eshell-isearch-backward)
    ))
(setq eshell-ask-to-save-history (quote always))
(setq eshell-history-size 100000)
(setq eshell-hist-ignoredups t)

;;;;
;;;; org-mode
;;;;
(require 'org-install)
(setq org-hide-leading-starts t)
;;;- remain settings
;;(define-key global-map "\C-cl" 'org-store-link )
;;(define-key global-map "\C-ca" 'org-agenda )
;;(define-key global-map "\C-cr" 'org-remember )
;;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode ) )
;;(add-hook 'org-mode-hook 'turn-on-font-lock )
;;(setq org-directory "~/org/" )
;;(setq org-default-notes-file "notes.org" )

;;;;
;;;; wdired
;;;;
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)



;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MY EXTENSIONS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;
;;;; QUICK-HIGHLIGHT
;;;;
(defface quick-highlight-color
  '((t (:box (:line-width 1 :color "gold") :weight bold )))
  "highlight-color for i-smart-hightlight-color")
(defvar quick-highlight-color 'quick-highlight-color)
(defun quick-highlight()
  (interactive)
  (let ( (re (or (thing-at-point 'symbol) "" )) )
    (setq font-lock-set-defaults nil)
    (font-lock-add-keywords nil (list (list re 0 quick-highlight-color t )))
    (font-lock-fontify-buffer)))
(global-set-key (kbd "C-;") 'quick-highlight)

;;;;
;;;; QUICK-BOOKMARK
;;;;
(defun qb-set()
  "set quick bookmark"
  (interactive)
  (progn (point-to-register ?t)
         (message "mark here" )))
(defun qb-go()
  "go quick bookmark"
  (interactive)
  (progn (jump-to-register ?t)
         (message "jump to mark!")))
(global-set-key (kbd "C-,") 'qb-set)
(global-set-key (kbd "C-." ) 'qb-go)
(define-key php-mode-map (kbd "C-,") 'qb-set)
(define-key js2-mode-map (kbd "C-,") 'qb-set)
(define-key php-mode-map (kbd "C-.") 'qb-go)
(define-key js2-mode-map (kbd "C-.") 'qb-go)



;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; KEY BINDINGS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;
;;;; BACKWARD-KILL-WORD
;;;;
(define-key global-map (kbd "C-j") 'backward-kill-word)
(define-key minibuffer-local-map (kbd "C-j") 'backward-kill-word)
(define-key minibuffer-local-ns-map (kbd "C-j") 'backward-kill-word)
(define-key minibuffer-local-isearch-map (kbd "C-j") 'backward-kill-word)
(define-key minibuffer-local-filename-completion-map (kbd "C-j") 'backward-kill-word)
(define-key minibuffer-local-completion-map (kbd "C-j") 'backward-kill-word)
(define-key minibuffer-local-must-match-filename-map (kbd "C-j") 'backward-kill-word)
(define-key minibuffer-local-filename-must-match-map (kbd "C-j") 'backward-kill-word)
(define-key anything-map (kbd "C-j") 'backward-kill-word)

;;;;
;;;; BACKWARD-DELETE-CHAR
;;;;
(define-key global-map (kbd "C-h") 'backward-delete-char)
(define-key anything-map (kbd "C-h") 'backward-delete-char)

;;;;
;;;; RECENTER
;;;;
(global-set-key (kbd "C-l") 'recenter)

;;;;
;;;; AUTO-INSTALL
;;;;
(require 'auto-install)

;;;;
;;;; OPEN-JUNK-FILE
;;;;
(require 'open-junk-file)
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;;;;
;;;; LISPXMP
;;;;
(require 'lispxmp)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'lispxmp)

;;;;
;;;; POPWIN
;;;;
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(add-to-list 'popwin:special-display-config '("*Backtrace*"))
(add-to-list 'popwin:special-display-config '("*Apropos*"))

;;;;
;;;; sun-mode
;;;;
(require 'sun-mode)
(add-to-list 'auto-mode-alist '("\\.sun$" . sun-mode))


;;;
;;; original connection
;;;
;(load-file "~/synphonie.el")
(load-file "~/create-on.el")



;; -- end of emacs --