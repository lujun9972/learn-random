(defvar learn-random-functions nil
  "functions to be learn")

(defun learn-random-function-update ()
  (interactive)
  (setq learn-random-functions nil)
  (mapatoms (lambda (symbol)
              (when (and (functionp symbol)
                         (get symbol 'byte-obsolete-info)
                         (documentation symbol))
                (push symbol learn-random-functions)))))

(defun learn-random-function ()
  (interactive)
  (unless learn-random-functions
    (learn-random-function-update))
  (let* ((limit (length learn-random-functions))
         (idx (random limit))
         (function-symbol (nth idx learn-random-functions)))
    (describe-function function-symbol)))

;; (get 'describe-function 'function-documentation)

;; (get 'string-to-int 'function-documentation)
;; (get-)
;; (get  'defun 'byte-obsolete-info)

;; (get 'string-to-int 'byte-obsolete-info)

;; (documentation 'auto-pause-pause-process)
;; (symbol-plist 'auto-pause-pause-process)
