;;; package --- summary
;;; Commentary:
;;; Code:

(defun markdown-html (buffer)
  "Markdown-html foo bar BUFFER."
  (princ (with-current-buffer buffer
          (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://strapdownjs.com/v/0.2/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
         (current-buffer)))

(defun markdown-filter (buffer)
  "Foo bar BUFFER."
  (princ
   (with-temp-buffer
     (let ((tmpname (buffer-name)))
       (set-buffer buffer)
       (set-buffer (markdown tmpname)) ; the function markdown is in `markdown-mode.el'
       (buffer-string)))
   (current-buffer)))




(use-package markdown-mode
  :ensure t
  :custom (auto-mode-alist
           (append
            auto-mode-alist
            '(("\\.text\\'" . markdown-mode)
              ("\\.markdown\\'" . markdown-mode)
              ("\\.md\\'" . markdown-mode))))
  :hook (markdown-mode-hook . (lambda () (flyspell-mode 1))))

(provide 'setup-md)
;;; setup-md.el ends here
