(defvar learn-random/functions nil
  "functions to be learn")

(defun learn-random/filter-function (symbol)
  (when (and (functionp symbol)
             (not (get symbol 'byte-obsolete-info))
             (documentation symbol)
             (not (string-prefix-p "\n" (documentation symbol))))
    (push symbol learn-random/functions)))

(defun learn-random/update-function ()
  (interactive)
  (setq learn-random/functions nil)
  (mapatoms #'learn-random/filter-function))

;;;###autoload
(defun learn-random-function ()
  (interactive)
  (unless learn-random/functions
    (learn-random/update-function))
  (let* ((limit (length learn-random/functions))
         (idx (random limit))
         (function-symbol (nth idx learn-random/functions)))
    (describe-function function-symbol)))


(defvar learn-random/variables nil
  "variables to be learn")

(defun learn-random/filter-variable (symbol)
  (when (and (boundp symbol)
             (not (get symbol 'byte-obsolete-info))
             (documentation-property symbol 'variable-documentation)
             (not (string= "" (documentation-property symbol 'variable-documentation))))
    (push symbol learn-random/variables)))

(documentation-property 'ediff-highlighting-style 'variable-documentation)

(defun learn-random/update-variable ()
  (interactive)
  (setq learn-random/variables nil)
  (mapatoms #'learn-random/filter-variable))

;;;###autoload
(defun learn-random-variable ()
  (interactive)
  (unless learn-random/variables
    (learn-random/update-variable))
  (let* ((limit (length learn-random/variables))
         (idx (random limit))
         (variable-symbol (nth idx learn-random/variables)))
    (describe-variable variable-symbol)))
(provide 'learn-random)
