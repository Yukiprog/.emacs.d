;;パッケージ管理の初期化
(require 'package)
;;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-archives
      '(
	("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.org/packages/")
	("org" . "http://orgmode.org/elpa/")
	))


(package-initialize)


;;背景色と文字色を変更
(set-background-color "black")
(set-foreground-color "#ffffff")

;;C-tでウィンドウを切り替える。初期値はtranspose-chars
(define-key global-map (kbd "C-t") 'other-window)

;;カラム番号も表示
(column-number-mode t)

;;左に行番号表示
(require 'linum)
(global-linum-mode)

;;ファイルサイズを表示
(size-indication-mode t)

;;時計を表示(好みに応じてフォーマットを変更可能)
;;(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time-mode t)

;;タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;;paren-mode:対応する括弧を強調して表示する
(setq show-paren-delay 0)
(show-paren-mode t)

;;TABの無効化とインデント幅を4にする
(setq-default c-basic-offset 4 tab-width 4 indent-tabs-mode nil)

 ;;自動インデントを実施する
(global-set-key "\C-m" 'newline-and-indent)

;;クリップボードを他のアプリと共有
(setq x-select-enable-clipboard t)

;;redo+の設定
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo))

;;メニューバー、ツールバー、スクロールバーを消去
(menu-bar-mode t)
(tool-bar-mode t)
(scroll-bar-mode 0)

;; ファイルを開いた位置を保存する
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))

;;;括弧の対応を保持して編集する設定
;;(require 'paredit)
;;(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
;;(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
;;(add-hook 'lisp-mode-hook 'enable-paredit-mode)
;;(add-hook 'ielm-mode-hook 'enable-paredit-mode)

;;neotree ディレクトリーツリーを表示
(global-set-key [f8] 'neotree-toggle)

;; 隠しファイルをデフォルトで表示
(setq neo-show-hidden-files t)

;; neotree ウィンドウを表示する毎に current file のあるディレクトリを表示する
(setq neo-smart-open t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ess julia-mode ac-php company-php docker docker-compose-mode docker-tramp dockerfile-mode php-mode rainbow-delimiters mozc company company-lsp lsp-ui ## flycheck use-package lsp-mode lsp-java neotree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;;command-log-mode
(require 'command-log-mode)

;; 警告音もフラッシュも全て無効(警告音が完全に鳴らなくなるので注意)
(setq ring-bell-function 'ignore)

;;company
(require 'company)
(global-company-mode) ; 全バッファで有効にする
(global-set-key (kbd "C-f") 'company-complete)
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

;;; mozc
(require 'mozc)                                 ; mozcの読み込み
(set-language-environment "Japanese")           ; 言語環境を"japanese"に
(setq default-input-method "japanese-mozc")     ; IMEをjapanes-mozcに
(prefer-coding-system 'utf-8)                   ; デフォルトの文字コードをUTF-8に
(global-set-key (kbd "C-/") 'toggle-input-method)

;; rainbow-delimiters を使うための設定
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; 括弧の色を強調する設定
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
    (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)

;; php-mode
(require 'php-mode)

;;docker用
(require 'docker)

;;dockerfileの編集用
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;;docker-composeファイル編集用
(require 'docker-compose-mode)

;;Trampを使用してコンテナ内に入れる。以下はコンテナIDではなく名前でアクセス出来るようにする設定
(require 'docker-tramp-compat)
(set-variable 'docker-tramp-use-names t)

;;Juliaモード
(add-to-list 'load-path "path-to-julia-mode")
(require 'julia-mode)

;;ess
(require 'ess-site)
