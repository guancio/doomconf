;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 28))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; GUANCIO

(setq doom-leader-alt-key "<f7>"
      doom-localleader-alt-key "<menu>"
      doom-leader-key ""
      doom-localleader-key "")

;; defaults
;; (setq default-fill-column 80)  ; toggle wrapping text at the 80th character

;; general- edit
(add-hook! 'after-init-hook #'cua-mode)
;; (require 'uniquify)

;; theme
;; (defun g-toggle-dark-light ()) TODO

;; start new emacs TODO
;; zoom TODO
;; new-buffer TODO
;; macros TODO
(map! :leader
      ;;; <leader> a --- applications
      (:prefix-map ("a" . "applications")
                   :desc "new frame"                               "n"   #'new-frame
                   ;; "ae" '(start-emacs :which-key "emacs")
                   :desc "quit"                                    "q"   #'save-buffers-kill-terminal)
            ;;; <leader> b --- buffer
      (:prefix-map ("b" . "buffer")
                   :desc "Toggle narrowing"            "-"   #'doom/toggle-narrow-buffer
                   :desc "Previous buffer"             "["   #'previous-buffer
                   :desc "Next buffer"                 "]"   #'next-buffer
                   (:when (featurep! :ui workspaces)
                          :desc "Switch workspace buffer" "b" #'persp-switch-to-buffer
                          :desc "Switch buffer"           "B" #'switch-to-buffer)
                   (:unless (featurep! :ui workspaces)
                            :desc "Switch buffer"           "b" #'switch-to-buffer)
                   :desc "Kill buffer"                 "d"   #'kill-current-buffer
                   :desc "ibuffer"                     "i"   #'ibuffer
                   :desc "Kill buffer"                 "k"   #'kill-current-buffer
                   :desc "Kill another buffer"         "K"   #'(lambda () (interactive)(kill-buffer))
                   :desc "Switch to last buffer"       "l"   #'evil-switch-to-windows-last-buffer
                   :desc "Set bookmark"                "m"   #'bookmark-set
                   :desc "Delete bookmark"             "M"   #'bookmark-delete
                   :desc "Next buffer"                 "n"   #'next-buffer
                   :desc "Kill other buffers"          "O"   #'doom/kill-other-buffers
                   :desc "Previous buffer"             "p"   #'previous-buffer
                   :desc "Pop up scratch buffer"       "x"   #'doom/open-scratch-buffer
                   :desc "Switch to scratch buffer"    "X"   #'doom/switch-to-scratch-buffer
                   :desc "Bury buffer"                 "z"   #'bury-buffer
                   :desc "Kill buried buffers"         "Z"   #'doom/kill-buried-buffers)
      ;;
      (:prefix-map ("f" . "file")
                   :desc "Find file"                   "f"   #'counsel-find-file
                   :desc "Find file from here"         "F"   #'+default/find-file-under-here
                   :desc "Revert buffer"               "g"   #'revert-buffer
                   :desc "New empty buffer"            "n"   #'evil-buffer-new
                   :desc "Save buffer"                 "s"   #'basic-save-buffer
                   :desc "Save buffer as"              "S"   #'write-file
                   :desc "Save all buffers"            "a"   #'save-some-buffers
                   ;; :desc "Sudo this file"              "s"   #'doom/sudo-this-file
                   ;; :desc "Save all buffers"            "S"   #'evil-write-all
                   ;; :desc "Save buffer as root"         "u"   #'doom/sudo-save-buffer
                   )
      ;; This should probably be in the xah key list
      (:prefix-map ("g" . "lookup")
                   :desc "Jump to symbol"          "s" #'imenu
                   :desc "Goto Line"               ":" #'goto-line
                   )
;;      ;; does not work
;;      ;; "ga" 'xref-find-apropos
      ;; We should also look at the bindings for <f1>
      (:prefix-map ("h" . "help")
                   :desc "Describe key"          "k" #'describe-key
                   :desc "Goto mode"             "m" #'describe-mode
                   :desc "Top-level keybinding"  "?" #'which-key-show-top-level
                   )
      ;; These definitely should be in xah keys
      (:prefix-map ("k" . "text")
                   :desc "Comment"               ";" #'comment-dwim
                   :desc "Copy"                  "c" #'kill-ring-save
                   :desc "Cut"                   "x" #'kill-ring
                   :desc "Paste"                 "v" #'yank
                   :desc "Paste list"            "V" #'counsel-yank-pop
                   :desc "Mark all"              "a" #'mark-whole-buffer
                   )
      ;; This is unclear if they shuld be here or in Xah
      (:prefix-map ("s" . "search")
                   :desc "Replace"               "h" #'replace-string
                   )
;;      "t"  '(:ignore t :which-key "Toggle")
;;      "t z" 'guancio-zoom/body
;;      "t M" 'disable-mouse
;;      "t l" 'toggle-light
      (:desc "Alt-x"                             "x" #'counsel-M-x)
      )

(map!
 "C-S-v"     #'counsel-yank-pop
 "C-<right>" #'right-word
 "C-<left>"  #'left-word
 )

(after! smartparens
  (map! :map smartparens-mode-map
   "C-<right>" #'right-word
   "C-<left>"  #'left-word
   ))

;;     (setq scroll-preserve-screen-position 1)
;;     (general-define-key
;;      "M-<up>" (lambda ()(interactive) (scroll-down-command 1))
;;      "M-<down>" (lambda ()(interactive) (scroll-up-command 1))

(setq which-key-idle-delay 0)

;; (setq g-qwerty-str "1234567890-=qwertyuiop[]\\asdfghjkl;'zxcvbnm,./")
;; (setq g-querty-list (mapcar 'char-to-string (append g-qwerty-str nil)))

;; (defun g-qwerty-cmp (a b)
;;   (let ((pos-a (cl-position (car a) g-querty-list :test 'equal))
;;         (pos-b (cl-position (car b) g-querty-list :test 'equal)))
;;     (cond ((and (not pos-a) (not pos-b)) (which-key-key-order a b))
;;           ((and (not pos-a) pos-b) nil)
;;           ((and pos-a (not pos-b)) t)
;;           ((and pos-a pos-b) (< pos-a pos-b)))))

;; (defun g-which-key-cmp (acons bcons)
;;   (let ((pos-a (cl-position (car acons) g-querty-list :test 'equal))
;;         (pos-b (cl-position (car bcons) g-querty-list :test 'equal))
;;         )
;;     (cond ((and (not pos-a) (not pos-b)) (string-lessp (downcase (cdr acons)) (downcase (cdr bcons))))
;;           ((and (not pos-a) pos-b) nil)
;;           ((and pos-a (not pos-b)) t)
;;           ((and pos-a pos-b) (string-lessp (downcase (cdr acons)) (downcase (cdr bcons)))))))

;; (defun g-which-key-cmp (acons bcons)
;;   (string-lessp (downcase (cdr acons)) (downcase (cdr bcons))))

;; (defun print-elements-of-list (list)
;;   "Print each element of LIST on a line of its own."
;;   (while list
;;     (message (car list))
;;     (setq list (cdr list))))
;; (print-elements-of-list '("gazelle" "giraffe" "lion" "tiger"))
;; (print-elements-of-list g-querty-list)
;; (message (number-to-string
;;           (cl-position "@" g-querty-list :test 'equal)))
;; (message (cl-position 2 '(6 7 8 2 3 4)))

;; (if (g-qwerty-cmp "a" "s") (message "yes"))
;; (if (g-qwerty-cmp "s" "a") (message "yes"))
;; (message (g-qwerty-cmp "t" "@"))

;; (defun prefix-last-then-by-keys (acons bcons)
;;   (let ((apref? (which-key--group-p (cdr acons)))
;;         (bpref? (which-key--group-p (cdr bcons))))
;;     (if (not (eq apref? bpref?))
;;         (and (not apref?) bpref?)
;;       (which-key-key-order acons bcons))))

;; (setq which-key-sort-order 'g-qwerty-cmp)
;; (setq which-key-sort-order 'g-which-key-cmp)


;; text
(add-hook! 'text-mode-hook 'auto-fill-mode)
(map! :leader
      ;;; <leader> a --- applications
      (:prefix-map ("t" . "toggle")
        :desc "Auto-fill"   "a"   #'auto-fill-mode))

;; prog TODO
;; org TODO
;; 


(map! :leader
      (:prefix-map ("a" . "applications")
        :desc "e-mail"   "m"   #'mu4e))
(after! mu4e
	(setq
	 mu4e-get-mail-command nil
	 mu4e-maildir       "~/mail/kth"   ;; top-level Maildir
	 mu4e-sent-folder   "/Sent Items"       ;; folder for sent messages
	 mu4e-drafts-folder "/Drafts"     ;; unfinished messages
	 mu4e-trash-folder  "/Deleted Items"      ;; trashed messages
	 mu4e-refile-folder "/INBOX.archive")   ;; saved messages
	;; a  list of user's e-mail addresses
	(setq mu4e-user-mail-address-list '("robertog@kth.se"))
	;; general emacs mail settings; used when composing e-mail
	;; the non-mu4e-* stuff is inherited from emacs/message-mode
	(setq mu4e-reply-to-address "robertog@kth.se"
	      user-mail-address "robertog@kth.se"
	      user-full-name  "Roberto Guanciale")
	(setq mu4e-compose-signature
	      "Roberto Guanciale\nKTH.se\n")

	;; delete password from smtp-auth
	;; smtp mail setting
	(setq message-send-mail-function 'smtpmail-send-it
	      smtpmail-stream-type 'starttls
	      smtpmail-default-smtp-server "smtp.kth.se"
	      smtpmail-smtp-server "smtp.kth.se"
	      smtpmail-smtp-service 587)
	;; don't keep message buffers around
	(setq message-kill-buffer-on-exit t)

	(setq mu4e-attachment-dir  "~/Downloads")

	;; to jump to folders using helm
	(setq mu4e-completing-read-function 'completing-read)

  (add-hook! mu4e-headers-mode
             xah-fly-insert-mode-activate)

  (map! :map mu4e-headers-mode-map
        :desc "↑"             "i"             #'previous-line
        :desc "←"             "j"             #'left-char
        :desc "↓"             "k"             #'next-line
        :desc "→"             "l"             #'right-char
        :desc "prev"          "u"             #'mu4e-headers-prev
        :desc "next"          "o"             #'mu4e-headers-next
        ;;
        :desc "trash"         "d"             #'mu4e-headers-mark-for-trash
        :desc "delete"        "D"             #'mu4e-headers-mark-for-delete
        :desc "mark thread"   "T"             #'mu4e-headers-mark-thread
        ;; "t" 'mu4e-headers-mark-thread-only select thread
        :desc "archive"       "a"             #'mu4e-headers-mark-for-refile
        :desc "unmark"        "z"             #'mu4e-headers-mark-for-unmark
        :desc "unmark all"    "Z"             #'mu4e-mark-unmark-all
        :desc "mark for"      "SPC"           #'mu4e-headers-mark-for-something
        :desc "unread"        "g"             #'mu4e-headers-mark-for-unread
        :desc "move"          "m"             #'mu4e-headers-mark-for-move
        :desc "edit"          "E"             #'mu4e-compose-edit
        ;; "s" star
        :desc "quit"          "q"             #'mu4e~headers-quit-buffer
        :desc "resolve marks" "x"             #'mu4e-mark-resolve-deferred-marks
        :desc "execute"       "e"             #'mu4e-mark-execute-all
        :desc "compose"       "c"             #'mu4e-compose-new
        :desc "forard"        "f"             #'mu4e-compose-forward
        :desc "reply"         "r"             #'mu4e-compose-reply
        :desc "jump to"       "y"             #'mu4e~headers-jump-to-maildir
        ;; to fix
        :desc "update"        "<f5>"          #'mu4e-update-index
        :desc "search narrow" "/"             #'mu4e-headers-search-narrow
        :desc "search edit"   "."             #'mu4e-headers-search-edit
        :desc "search new"    ","             #'mu4e-headers-search
        ;; "M-/" 'helm-mu
        ;; " 'helm-mu-contacts
        :desc "query prev"    "["             #'mu4e-headers-query-prev
        :desc "query next"    "]"             #'mu4e-headers-query-next
        :desc "help"          "?"             #'which-key-show-top-level

        (:prefix-map ("t"."toggle")
          :desc "threading"   "t"             #'mu4e-headers-toggle-threading
          :desc "full-search" "f"             #'mu4e-headers-toggle-full-search
          :desc "duplicates"  "d"             #'mu4e-headers-toggle-skip-duplicates
          :desc "sorting"     "s"             #'mu4e-headers-change-sorting
          :desc "related"     "r"             #'mu4e-headers-toggle-include-related
          )
        )
  ;; not binded
  ;; ;; %		mu4e-headers-mark-pattern
  ;; ;; &		mu4e-headers-mark-custom
  ;; ;; +		mu4e-headers-mark-for-flag
  ;; ;; -		mu4e-headers-mark-for-unflag
  ;; ;; ;		mu4e-context-switch
  ;; ;; <		beginning-of-buffer
  ;; ;; =		mu4e-headers-mark-for-untrash
  ;; ;; >		end-of-buffer
  ;; ;; A		mu4e-headers-mark-for-action
  ;; ;; B		mu4e-headers-search-bookmark-edit
  ;; ;; E		mu4e-compose-edit
  ;; ;; H		mu4e-display-manual
  ;; ;; [		mu4e-headers-prev-unread
  ;; ;; \		mu4e-headers-query-prev
  ;; ;; ]		mu4e-headers-next-unread
  ;; ;; a		mu4e-headers-action
  ;; ;; b		mu4e-headers-search-bookmark
  ;; main page
  (map! :map mu4e-view-mode-map
        :desc "↑"             "i"             #'previous-line
        :desc "←"             "j"             #'left-char
        :desc "↓"             "k"             #'next-line
        :desc "→"             "l"             #'right-char
        :desc "prev"          "u"             #'mu4e-view-headers-prev
        :desc "next"          "o"             #'mu4e-view-headers-next
        ;;
        :desc "trash"         "d"             #'mu4e-view-mark-for-trash
				:desc "delete"        "D"             #'mu4e-view-mark-for-delete
				:desc "mark thread"   "T"             #'mu4e-view-mark-thread
        :desc "archive"       "a"             #'mu4e-view-mark-for-refile
				:desc "unmark"        "z"             #'mu4e-view-mark-for-unmark
        :desc "unmark all"    "Z"             #'mu4e-view-mark-unmark-all
        :desc "mark for"      "SPC"           #'mu4e-view-mark-for-something
				:desc "unread"        "g"             #'mu4e-view-mark-for-unread
				:desc "move"          "m"             #'mu4e-view-mark-for-move
        ;; "s" star
        :desc "quit"          "q"             #'mu4e~view-quit-buffer
        :desc "resolve marks" "x"             #'mu4e-mark-resolve-deferred-marks
        :desc "execute"       "e"             #'mu4e-view-marked-execute
        ;;
        :desc "compose"       "c"             #'mu4e-compose-new
        :desc "forard"        "f"             #'mu4e-compose-forward
        :desc "reply"         "r"             #'mu4e-compose-reply
        :desc "jump to"       "y"             #'mu4e~headers-jump-to-maildir
        ;; to fix
        :desc "update"        "<f5>"          #'mu4e-update-index
        :desc "search narrow" "/"             #'mu4e-view-search-narrow
        :desc "search edit"   "."             #'mu4e-view-search-edit
        :desc "search new"    ","             #'mu4e-headers-search
        :desc "query prev"    "["             #'mu4e-headers-query-prev
        :desc "query next"    "]"             #'mu4e-headers-query-next
        :desc "help"          "?"             #'which-key-show-top-level
        :desc "opne url"      "w"             #'mu4e-view-go-to-url

        (:prefix-map ("t"."toggle")
          :desc "cited"       "c" #'mu4e-view-toggle-hide-cited
          :desc "row"         "0" #'mu4e-view-raw-message
          :desc "threading"   "t" #'mu4e-headers-toggle-threading
          :desc "full-search" "f" #'mu4e-headers-toggle-full-search
          :desc "duplicates"  "d" #'mu4e-headers-toggle-skip-duplicates
          :desc "sorting"     "s" #'mu4e-headers-change-sorting
          :desc "related"     "r" #'mu4e-headers-toggle-include-related
          :desc "html"        "h" #'mu4e-view-toggle-html
          :desc "address"     "a" #'(lambda ()((interactive))
                                    (setq mu4e-view-show-addresses (not mu4e-view-show-addresses))
                                    (mu4e-view-refresh)
                                    )
          )
        ;; open with emacs
        "A" nil
        (:prefix ("A"."attachment")
          :desc "view" "a" 'mu4e-view-attachment-action
          :desc "save" "s" 'mu4e-view-save-attachment
          :desc "open" "o" 'mu4e-view-open-attachment
          )
        )

  (map! :map mu4e-view-contacts-header-keymap
        :desc "copy"    "C" 'mu4e~view-copy-contact
        :desc "compose" "c" 'mu4e-view-compose-contact
        )

  (map! :localleader
    :map mu4e-compose-mode-map
    :desc "attach" "a" #'mml-attach-file
    :desc "body"   "b" #'message-goto-body
    :desc "send and close"   "c" #'message-send-and-exit
    :desc "quit"   "q" #'message-kill-buffer
    :desc "send"   "s" #'message-send
    )
  )

;; spell
(defun spell-checking/change-dictionary ()
  "Change the dictionary. Use the ispell version if
auto-dictionary is not used, use the adict version otherwise."
  (interactive)
  (if (fboundp 'adict-change-dictionary)
      (adict-change-dictionary)
    (call-interactively 'ispell-change-dictionary)))

(defhydra hydra-spelling (:color blue)
  "
  ^
  ^Spelling^          ^Errors^            ^Checker^
  ^────────^──────────^──────^────────────^───────^───────
  _q_ quit            _p_ previous        _c_ correction
  ^^                  _n_ next            _d_ dictionary
  ^^                  _b_ buffer          ^^
  ^^                  ^^                  ^^
  "
  ("q" nil)
  ("p" evil-prev-flyspell-error :color pink) ;; TODO
  ("n" evil-next-flyspell-error :color pink) ;; TODO
  ("c" flyspell-correct-next) ;; TODO Should not quit
  ("d" spell-checking/change-dictionary)
  ("b" flyspell-buffer))

(after! flyspell
  (map! :leader
        (:prefix-map ("S"."spelling")
          :desc "buffer" "b" #'flyspell-buffer
          ;; def-word TODO
          :desc "change dictionary" "d" #'spell-checking/change-dictionary
          :desc "next error" "n" #'flyspell-goto-next-error
          :desc "correct" "S" #'flyspell-correct-next
          :desc "hydra" "." #'hydra-spelling/body
          ))
  )

;; toggle TODO
;; modal editing TODO
;;
(after! tex
  (defvar latex-nofill-env '("equation"
                             "equation*"
                             "tabular"
                             "tikzpicture")
    "List of environment names in which `auto-fill-mode' will be inhibited.")
  (defun latex//no-autofillp ()
    "Check whether the pointer is currently inside one of the
environments described in `latex-nofill-env' and if so, inhibits
the automatic filling of the current paragraph."
    (let ((do-auto-fill t)
          (current-environment "")
          (level 0))
      (while (and do-auto-fill (not (string= current-environment "document")))
        (setq level (1+ level)
              current-environment (LaTeX-current-environment level)
              do-auto-fill (not (member current-environment latex-nofill-env))))
      (not do-auto-fill)))
  (setq-hook! 'TeX-mode-hook
    ;; Don't auto-fill in math blocks
    fill-nobreak-predicate (cons #'latex//noautofillp (cons #'texmathp fill-nobreak-predicate)))

  ;; TODO does not work
  (setq +latex-viewers '(pdf-tools)
        TeX-auto-save t)

  ;; company-ispell TODO
  (defun latex/build ()
    (interactive)
    (progn
      (TeX-save-document (TeX-master-file))
      (TeX-command "LaTeX" 'TeX-master-file -1)))

  (map! :localleader
   :map TeX-mode-map
   :desc "recent ouput log buffer" "l" #'TeX-recenter-output-buffer
   :desc "next error"              "`" #'TeX-next-error
   :desc "run all"                 "a" #'TeX-command-run-all
   :desc "build"                   "b" #'latex/build
   :desc "kill job"                "k" #'TeX-kill-job
   :desc "view"                    "v" #'TeX-view
   ;; what to do with the other 2000 keymaps?
   ;; macro?
   ;; standard compilation
   )
  (map! :leader
        :map TeX-mode-map
        (:prefix-map ("t"."toggle")
          :desc "master file" "m"   #'TeX-master-file-ask)
        )
  )






;; dired TODO

;; window

;; delete window and buffers
;; Maybe it is better to connect this to the kill-buffer-hook
(defun g/kill-buffer-may-delete-window ()
  (interactive)
  (let ((window_history (window-prev-buffers)))
    (progn
      (kill-buffer)
      (if (eq window_history nil)
          (delete-window))
      )))

;; maximize at startup
(after! winum
  (map! :leader
        (:prefix-map ("b"."buffer")
          :desc "kill buffer / delete window" "q" #'g/kill-buffer-may-delete-window
          )
        )
  (map!
   (:prefix-map ("<f8>"."window")
     :desc "window 0" "0" #'winum-select-window-0-or-10
     :desc "window 1" "1" #'winum-select-window-1
     :desc "window 2" "2" #'winum-select-window-2
     :desc "window 3" "3" #'winum-select-window-3
     :desc "window 4" "4" #'winum-select-window-4
     :desc "window 5" "5" #'winum-select-window-5
     :desc "window 6" "6" #'winum-select-window-6
     :desc "window 7" "7" #'winum-select-window-7
     :desc "window 8" "8" #'winum-select-window-8
     :desc "window 9" "9" #'winum-select-window-9
     :desc "maximize" "a" #'toggle-frame-maximized
     :desc "delete"   "d" #'delete-window
     :desc "kill buffer / delete window" "q" #'g/kill-buffer-may-delete-window
     :desc "switch buffer" "b" #'+ivy/switch-workspace-buffer
     :desc "undo"     "z" #'winner-undo
     :desc "redo"     "u" #'winner-redo
     :desc "delete others" "o" #'delete-other-windows
     )))
(map!
 :desc "↑"             "s-i"             #'windmove-up
 :desc "←"             "s-j"             #'windmove-left
 :desc "↓"             "s-k"             #'windmove-down
 :desc "→"             "s-l"             #'windmove-right
 :desc "↑"             "s-<up>"             #'windmove-up
 :desc "←"             "s-<left>"             #'windmove-left
 :desc "↓"             "s-<down>"             #'windmove-down
 :desc "→"             "s-<right>"             #'windmove-right
 ;; should use evil-window
)


(defun g/empty-left (&optional window)
  (let ((w (if (eq window nil) (selected-window) window)))
    (split-window w nil 'left)
    (g/remove-selection)
    ))
(defun g/empty-above (&optional window)
  (let ((w (if (eq window nil) (selected-window) window)))
    (split-window w nil 'above)
    (g/remove-selection)
    ))
(defun g/empty-right (&optional window)
  (let ((w (if (eq window nil) (selected-window) window)))
    (split-window w nil 'right)
    (g/remove-selection)
    ))
(defun g/empty-below (&optional window)
  (let ((w (if (eq window nil) (selected-window) window)))
    (split-window w nil 'below)
    (g/remove-selection)
    ))

(setq last-selected nil)

(defun g/color-layer (window)
  (if (not (eq window nil))
      (progn
	(g/color-all window)
	(g/color-layer (window-next-sibling window))
	)))

(defun g/color-all (window)
  (let ((c (window-child window)))
    (if (eq c nil)
     	(let ((over (make-overlay 1 100000 (window-buffer window))))
     	  (progn
     	    (overlay-put over 'face '(:background "#001100"))
     	    (overlay-put over 'window window)
     	    ))
      (g/color-layer c)
      )
    )
  )

(defun g/color-none ()
  (mapcar (lambda (window)
	    (with-current-buffer (window-buffer window)
	      (remove-overlays )))
	  (window-list)))


(defun g/up-selection ()
  (interactive)
  (progn
    (if (eq last-selected nil)
	(setq last-selected (selected-window))
      (setq last-selected (window-parent last-selected)))
    (g/color-none)
    (g/color-all last-selected)
    ))
(defun g/remove-selection()
  (interactive)
  (progn
    (setq last-selected nil)
    (g/color-none)))


(setq g/copied-window nil)

(defun g/copy-window ()
  (interactive)
  (let ((b (current-buffer))
	(w (selected-window)))
    (setq g/copied-window (list b nil))
    ))
(defun g/cut-window ()
  (interactive)
  (let ((b (current-buffer))
	(w (selected-window)))
    (setq g/copied-window (list b w))
    ))
(defun g/paste-window ()
  (interactive)
  (if (not (eq g/copied-window nil))
      (let ((b (car g/copied-window))
	    (w (cdr g/copied-window)))
	(progn
	  (set-window-buffer (selected-window) (car g/copied-window))
	  (if (not (eq w nil))
	      (progn
		(switch-to-prev-buffer w t)
		(setq g/copied-window (list b (current-window)))
		)))
	)))


;; Moving Buffers
;; Copied from buffer-move
;; when we move a buffer, we should also remove it from the list
;; of buffers for the current window.
;; (require 'windmove)
(defun g/buf-move (direction)
  (interactive)
  (let* ((other-win (windmove-find-other-window direction))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No window above this one")
      (switch-to-prev-buffer (selected-window) t)
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))
(defun g/buf-move-up ()
  (interactive)
  (g/buf-move 'up))
;; problems with the minibuffer
(defun g/buf-move-down ()
  (interactive)
  (g/buf-move 'down))
(defun g/buf-move-left ()
  (interactive)
  (g/buf-move 'left))
(defun g/buf-move-right ()
  (interactive)
  (g/buf-move 'right))


(defun g/move-to (arg)
  (interactive)
  (let ((b (current-buffer))
	(w (selected-window)))
    (winum-select-window-by-number arg)
    (set-window-buffer (selected-window) b)
    (switch-to-prev-buffer w t)
  ))



(setq g/resize-selected-edge nil)

(defun g/resize-right (&optional cols)
  (interactive)
  (let ((s (if (eq cols nil) 1 cols)))
    (cond
     ((eq g/resize-selected-edge 'right)
      (adjust-window-trailing-edge (selected-window) s t))
     ((eq g/resize-selected-edge 'left)
      (adjust-window-trailing-edge (window-in-direction 'left (selected-window)) s t))
     (t (setq g/resize-selected-edge 'right))
     )))
(defun g/resize-left (&optional cols)
  (interactive)
  (let ((s (if (eq cols nil) 1 cols)))
    (cond
     ((eq g/resize-selected-edge 'right)
      (adjust-window-trailing-edge (selected-window) (- 0 s) t))
     ((eq g/resize-selected-edge 'left)
      (adjust-window-trailing-edge (window-in-direction 'left (selected-window)) (- 0 s) t))
     (t (setq g/resize-selected-edge 'left))
     )))
(defun g/resize-below (&optional cols)
  (interactive)
  (let ((s (if (eq cols nil) 1 cols)))
    (cond
     ((eq g/resize-selected-edge 'below)
      (adjust-window-trailing-edge (selected-window) s))
     ((eq g/resize-selected-edge 'above)
      (adjust-window-trailing-edge (window-in-direction 'above (selected-window)) s))
     (t (setq g/resize-selected-edge 'below))
     )))
(defun g/resize-above (&optional cols)
  (interactive)
  (let ((s (if (eq cols nil) 1 cols)))
    (cond
     ((eq g/resize-selected-edge 'below)
      (adjust-window-trailing-edge (selected-window) (- 0 s)))
     ((eq g/resize-selected-edge 'above)
      (adjust-window-trailing-edge (window-in-direction 'above (selected-window)) (- 0 s)))
     (t (setq g/resize-selected-edge 'above))
     )))

(defhydra guancio-resize ()
  "
Resize (S-fast)  ^Centered (S-fast) ^
----------------------------------------------------------------
 ↑                   i
←↓→                 jkl
_<backspace>_ cancel _<return>_uit
"
  ("l" g/resize-right)
  ("L" (lambda ()(interactive) (g/resize-right 5)))
  ("j" g/resize-left)
  ("J" (lambda ()(interactive) (g/resize-left 5)))
  ("i" g/resize-above)
  ("I" (lambda ()(interactive) (g/resize-above 5)))
  ("k" g/resize-below)
  ("K" (lambda ()(interactive) (g/resize-below 5)))
  ("<right>" g/resize-right)
  ("<S-right>" (lambda ()(interactive) (g/resize-right 5)))
  ("<left>" g/resize-left)
  ("<S-left>" (lambda ()(interactive) (g/resize-left 5)))
  ("<up>" g/resize-above)
  ("<S-up>" (lambda ()(interactive) (g/resize-above 5)))
  ("<down>" g/resize-below)
  ("<S-down>" (lambda ()(interactive) (g/resize-below 5)))
  ("SPC" (lambda ()(interactive) (setq g/resize-selected-edge nil)))
  ("<backspace>" nil :exit t)
  ("<return>" nil)
  )

(defun g/open-resize ()
  (interactive)
  (progn
    (setq g/resize-selected-edge nil)
    (guancio-resize/body)))




(map!
 (:prefix-map ("<f8>"."window")
   (:prefix-map ("s"."split")
     :desc "↑"             "i"             #'(lambda() (interactive) (g/empty-above last-selected))
     :desc "←"             "j"             #'(lambda() (interactive) (g/empty-left last-selected))
     :desc "↓"             "k"             #'(lambda() (interactive) (g/empty-below last-selected))
     :desc "→"             "l"             #'(lambda() (interactive) (g/empty-right last-selected))
     :desc "↑"             "<up>"             #'(lambda() (interactive) (g/empty-above last-selected))
     :desc "←"             "<left>"             #'(lambda() (interactive) (g/empty-left last-selected))
     :desc "↓"             "<down>"             #'(lambda() (interactive) (g/empty-below last-selected))
     :desc "→"             "<right>"             #'(lambda() (interactive) (g/empty-right last-selected))
     )
   (:prefix-map ("m"."move")
     :desc "1" "1" #'(lambda () (interactive)(g/move-to 1))
     :desc "2" "2" #'(lambda () (interactive)(g/move-to 2))
     :desc "3" "3" #'(lambda () (interactive)(g/move-to 3))
     :desc "4" "4" #'(lambda () (interactive)(g/move-to 4))
     :desc "5" "5" #'(lambda () (interactive)(g/move-to 5))
     :desc "6" "6" #'(lambda () (interactive)(g/move-to 6))
     :desc "7" "7" #'(lambda () (interactive)(g/move-to 7))
     :desc "8" "8" #'(lambda () (interactive)(g/move-to 8))
     :desc "9" "9" #'(lambda () (interactive)(g/move-to 9))
     )
   :desc "resize" "r" #'g/open-resize
   :desc "copy"  "c" #'g/copy-window
   :desc "cut"   "x" #'g/cut-window
   :desc "paste" "v" #'g/paste-window

    ;; Possibly repeat some workspace in s- and f8
 ;; Remove the standard workspace from leader
 (:prefix-map ("w" . "workspaces/windows")
   :desc "Delete workspace"             "d" #'+workspace/delete
   :desc "Load session"                 "f" #'doom/load-session
   :desc "List workspaces"              "l" #'+workspace/display
   :desc "Switch to left workspace"     "[" #'+workspace/switch-left
   :desc "Switch to right workspace"    "]" #'+workspace/switch-right
   :desc "Switch to other workspace"    "<tab>" #'+workspace/other
   :desc "Autosave session"             "a" #'doom/quicksave-session
   :desc "Rename workspace"             "r" #'+workspace/rename
   :desc "Create workspace"             "c" #'+workspace/new
   :desc "Delete workspace"             "k" #'+workspace/delete
   :desc "Save session"                 "s" #'doom/save-session
   :desc "Save workspace"               "S" #'+workspace/save
   :desc "Load session"                 "l" #'doom/load-session
   :desc "Load last autosaved session"  "L" #'doom/quickload-session
   :desc "Switch to other workspace"    "o" #'+workspace/other
   :desc "Undo window config"           "u" #'winner-undo
   :desc "Redo window config"           "U" #'winner-redo
   :desc "Switch to left workspace"     "p" #'+workspace/switch-left
   :desc "Switch to right workspace"    "n" #'+workspace/switch-right
   :desc "Switch to"                    "w" #'+workspace/switch-to
   :desc "Switch to workspace 1"        "1" #'+workspace/switch-to-0
   :desc "Switch to workspace 2"        "2" #'+workspace/switch-to-1
   :desc "Switch to workspace 3"        "3" #'+workspace/switch-to-2
   :desc "Switch to workspace 4"        "4" #'+workspace/switch-to-3
   :desc "Switch to workspace 5"        "5" #'+workspace/switch-to-4
   :desc "Switch to workspace 6"        "6" #'+workspace/switch-to-5
   :desc "Switch to workspace 7"        "7" #'+workspace/switch-to-6
   :desc "Switch to workspace 8"        "8" #'+workspace/switch-to-7
   :desc "Switch to workspace 9"        "9" #'+workspace/switch-to-8
   :desc "Switch to last workspace"     "0" #'+workspace/switch-to-final   )
)
 :desc "Parent window" "s-w" #'g/up-selection
 :desc "Leaf window"   "s-s" #'g/remove-selection
 :desc "Move buffer above" "s-I" #'g/buf-move-up
 :desc "Move buffer left"  "s-J" #'g/buf-move-left
 :desc "Move buffer below" "s-K" #'g/buf-move-down
 :desc "Move buffer right" "s-L" #'g/buf-move-up
 :desc "Move buffer above" "S-s-<up>" #'g/buf-move-up
 :desc "Move buffer left"  "S-s-<left>" #'g/buf-move-left
 :desc "Move buffer below" "S-s-<down>" #'g/buf-move-down
 :desc "Move buffer right" "S-s-<right>" #'g/buf-move-up
 )


;; elisp TODO
;; lsp TODO
;; python TODO
;; cpp TODO
;; shell TODO
;; git TODO
;; project TODO

(use-package! xah-fly-keys
  :init
  ;; code here will run immediately
  :config
  ;; code here will run after the package is loaded
  (xah-fly-keys-set-layout 'qwerty)
  (define-key xah-fly-shared-map (kbd "<f7>") nil)
  (define-key xah-fly-shared-map (kbd "<f8>") nil)
  (define-key xah-fly-shared-map (kbd "<f9>") 'xah-fly-mode-toggle)
  (define-key xah-fly-shared-map (kbd "<menu>") nil)
  (define-key xah-fly-shared-map (kbd "<f11>") nil)
  (define-key global-map (kbd "<f11>") nil)
  (define-key xah-fly-command-map (kbd "?") 'which-key-show-top-level)
  (map! :map xah-fly-command-map
        "`" nil; other-frame
        :desc "Hypen-unrescore-space" "1" #'xah-cycle-hyphen-underscore-space
        "2" nil; xah-select-line repetition
        "3" nil; delete-other-windows
        "4" nil; split-window-below)
        :desc "Delete char" "5" #'delete-char
        :desc "Select block" "6" #'xah-select-block
        :desc "Select line" "7" #'xah-select-line
        :desc "Select extend" "8" #'xah-extend-selection
        :desc "Select in quote" "9" #'xah-select-text-in-quote
        :desc "Pop local mark" "0" #'xah-pop-local-mark-ring
        :desc "Backward Punct" "-" #'xah-backward-punct
        :desc "Forward Punct" "=" #'xah-forward-punct

        :desc "Reformat lines" "q" #'xah-reformat-lines
        :desc "Shrink whitespace" "w" #'xah-shrink-whitespaces
        :desc "Delete word backward" "e" #'xah-backward-kill-word
        :desc "Delete word" "r" #'xah-kill-word
        :desc "Set mark" "t" #'set-mark-command
        "y" nil; undo repetition
        :desc "Backward word" "u" #'backward-word
        :desc "Previous line" "i" #'previous-line
        :desc "Forward word" "o" #'forward-word
        :desc "Insert space" "p" #'xah-insert-space-before
        :desc "Hippie expand" "[" #'hippie-expand
        :desc "Forward equal sign" "]" #'xah-forward-equal-sign
        "\\" nil

        "a" nil; xah-fly-M-x
        :desc "Open line" "s" #'open-line
        :desc "Delete backward braket" "d" #'xah-delete-backward-char-or-bracket-text
        :desc "Delete backward" "f" #'backward-delete-char-untabify
        :desc "Delete block" "g" #'xah-delete-current-text-block
        :desc "Begin line/block" "h" #'xah-beginning-of-line-or-block
        :desc "Backward char" "j" #'backward-char
        :desc "Next line" "k" #'next-line
        :desc "Forward char" "l" #'forward-char
        :desc "End line/block" ";" #'xah-end-of-line-or-block
        :desc "Comment" "'" #'xah-comment-dwim

        :desc "Undo" "z" #'undo
        :desc "Cut line/region" "x" #'xah-cut-line-or-region
        :desc "Copy line/region" "c" #'xah-copy-line-or-region
        :desc "Paste" "v" #'xah-paste-or-paste-previous
        :desc "Toggle letter case" "b" #'xah-toggle-letter-case
        :desc "Iseach forward" "n" #'isearch-forward
        :desc "Backward (" "m" #'xah-backward-left-bracket
        "," nil; xah-next-window-or-frame
        :desc "Forward )" "." #'xah-forward-right-bracket
        :desc "Goto matchin ()" "/" #'xah-goto-matching-bracket

        :desc "Leader" "<SPC>" #'xah-fly-leader-key-map
        )

  (map! :map xah-fly-leader-key-map
        ;; ("TAB" . xah-fly--tab-key-map)
        ;; ("e" . xah-fly-dot-keymap)
        ;; ("q" . xah-fill-or-unfill) ;; Seems logic similar to reformat
        ;; ("w" . xah-fly-comma-keymap)
        ;; ("'" . xah-show-formfeed-as-line) ;; no idea what it does
        ;; ("\\" . toggle-input-method) ;; pointless, maybe change dic language?
        ;; ("3" . delete-window) ;; Remove: duplicate
        ;; ("4" . split-window-right) ;; Remove: duplicate
        ;; ("5" . balance-windows) ;; Remove and add to the window menu
        ;; ("6" . xah-upcase-sentence) ;; can make sense since 6 selects block
        ;; ("9" . ispell-word) ;; maybe not the right place
        ;; ("a" . mark-whole-buffer) ;; standard name, a is free in the main layer
        ;; ("n" . end-of-buffer) ;; not sure since there is isearch there
        ;; ("i" . xah-fly-c-keymap)
        ;; ("h" . beginning-of-buffer) ;; Make sense since it is begin of line
        ;; ("d" . xah-fly-e-keymap)
        ;; ("y" . xah-search-current-word) ;; free in the main layer
        ;; ("u" . xah-close-current-buffer) ;; not good choice since it is prev-word
        ;; ("j" . xah-fly-h-keymap)
        ;; ("g" . kill-line) ;; make sens, it was kill block
        ;; ("c" . xah-copy-all-or-region)
        ;; ("v" . xah-paste-or-paste-previous) ;; duplication. I should use ivy paste
        ;; ("p" . recenter-top-bottom) ;; mayme does not make sens position
        ;; ("m" . dired-jump)
        ;; ("l" . xah-fly-n-keymap)
        ;; ("s" . exchange-point-and-mark)
        ;; ("r" . query-replace)
        ;; ("q" . xah-cut-all-or-region)
        ;; ("o" . xah-fly-r-keymap)
        ;; (";" . save-buffer)
        ;; ("k" . xah-fly-t-keymap)
        ;; ("f" . switch-to-buffer)
        ;; ("," . xah-fly-w-keymap)
        ;; ("b" . xah-toggle-previous-letter-case)
        ;; ("t" . xah-show-kill-ring)
        )

  (map! :map xah-fly-shared-map
        (:prefix-map ("<f11>" . "buffer local")
          (:prefix-map ("<f11>" . "letters")
            :desc "α" "a" #'(lambda () (interactive) (insert "\\alpha"))
            :desc "β" "b" #'(lambda () (interactive) (insert "\\beta"))
            :desc "ɣ" "g" #'(lambda () (interactive) (insert "\\gamma"))
            :desc "Γ" "G" #'(lambda () (interactive) (insert "\\Gamma"))
            :desc "δ" "d" #'(lambda () (interactive) (insert "\\delta"))
            :desc "Δ" "D" #'(lambda () (interactive) (insert "\\Delta"))
            :desc "ε" "e" #'(lambda () (interactive) (insert "\\epsilon"))
            :desc "ζ" "z" #'(lambda () (interactive) (insert "\\zeta"))
            :desc "η" "e" #'(lambda () (interactive) (insert "\\eta"))
            :desc "θ" "t" #'(lambda () (interactive) (insert "\\teta"))
            :desc "Θ" "T" #'(lambda () (interactive) (insert "\\Teta"))
            :desc "ι" "i" #'(lambda () (interactive) (insert "\\iota"))
            :desc "λ" "l" #'(lambda () (interactive) (insert "\\lambda"))
            :desc "Λ" "L" #'(lambda () (interactive) (insert "\\Lambda"))
            :desc "μ" "m" #'(lambda () (interactive) (insert "\\mu"))
            :desc "ν" "n" #'(lambda () (interactive) (insert "\\nu"))
            :desc "ξ" "x" #'(lambda () (interactive) (insert "\\xi"))
            :desc "Ξ" "X" #'(lambda () (interactive) (insert "\\Xi"))
            :desc "π" "pi" #'(lambda () (interactive) (insert "\\pi"))
            :desc "Π" "P" #'(lambda () (interactive) (insert "\\Pi"))
            :desc "σ" "s" #'(lambda () (interactive) (insert "\\sigma"))
            :desc "Σ" "S" #'(lambda () (interactive) (insert "\\Sigma"))
            :desc "τ" "t" #'(lambda () (interactive) (insert "\\tau"))
            :desc "υ" "y" #'(lambda () (interactive) (insert "\\upsilon"))
            :desc "φ" "f" #'(lambda () (interactive) (insert "\\phi"))
            :desc "Φ" "F" #'(lambda () (interactive) (insert "\\Phi"))
            :desc "χ" "c" #'(lambda () (interactive) (insert "\\chi"))
            :desc "ψ" "ps" #'(lambda () (interactive) (insert "\\phi"))
            :desc "Ψ" "P" #'(lambda () (interactive) (insert "\\Phi"))
            :desc "ω" "o" #'(lambda () (interactive) (insert "\\omega"))
            :desc "Ω" "O" #'(lambda () (interactive) (insert "\\Omega"))
            )
          (:prefix-map ("<SPC>" . "symbols")
            :desc "Σ" "s" #'(lambda () (interactive) (insert "\\Sum"))
            )
          :desc "0" "z" #'(lambda () (interactive) (insert "\\gmpty{}{}"))
          :desc "A-x->B" "x" #'(lambda () (interactive) (yas-expand-snippet "\\gint{$1}{$2}{$3}"))
          :desc "G;G" "c" #'(lambda () (interactive) (insert "\\gseq{}{}"))
          :desc "G+G" "v" #'(lambda () (interactive) (insert "\\gsel{}{}"))
          :desc "G|G" "b" #'(lambda () (interactive) (insert "\\gpar{}{}"))
          :desc "A-x->B" "a" #'(lambda () (interactive) (yas-expand-snippet "\\gint{$1_{$4}}{$2_{$4}}{$3_{$4}}"))
          ))


(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
  (xah-fly-keys)
  )

(load "/home/guancio/Utils/HOL/tools/hol-mode")
;; HOL4
(define-key global-map (kbd "<menu>") nil)
(map! :localleader
      :map sml-mode-map
      :desc "start hol" "h" #'hol
      )

;; (require 'disp-table)
;; (require 'nano-theme-light)
;; (require 'nano-help)
;; (require 'nano-modeline)
;; (require 'nano-layout)
