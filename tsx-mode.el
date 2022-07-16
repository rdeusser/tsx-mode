;;; tsx-mode --- tsx-mode configuration.

;;; Commentary:

;;; Code:
(require 'rx)
(require 'typescript-mode)
(require 'tree-sitter)

(tree-sitter-require 'typescript)

(defgroup tsx nil
  "Major mode for tsx."
  :group 'languages
  :prefix "tsx-")

(defcustom tsx-mode-hook nil
  "Hook run by tsx-mode."
  :type 'hook
  :group 'tsx)

(defcustom tsx-indent-offset 2
  "Tab width to use when indenting."
  :type 'integer
  :group 'tsx)

(defvar tsx-html-tag-face
  (rx (or "<" "</")
      (zero-or-more alpha)
      (or "" ">")))

(defvar tsx-font-lock-defaults
  `(((,tsx-html-tag-face . font-lock-constant-face))))

(defvar tsx-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?< "(>" table)
    (modify-syntax-entry ?> ")<" table)
    (modify-syntax-entry ?: "_" table)
    (modify-syntax-entry ?_ "_" table)
    (modify-syntax-entry ?. "_" table)
    table)
  "Syntax table for tsx.")

(define-derived-mode tsx-mode typescript-mode
  "tsx"
  "Major-mode for tsx."
  :syntax-table tsx-mode-syntax-table
  (setq font-lock-defaults tsx-font-lock-defaults)
  (tree-sitter-hl-mode))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-mode))

(provide 'tsx-mode)

;;; tsx-mode.el ends here
