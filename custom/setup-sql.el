(defun sql-find-sqli-buffer (&optional product connection)
  "Returns the name of the current default SQLi buffer or nil.
In order to qualify, the SQLi buffer must be alive, be in
`sql-interactive-mode' and have a process."
  (let ((buf  sql-buffer)
        (prod (or product sql-product)))
    (or
     ;; Current sql-buffer, if there is one.
     (and (sql-buffer-live-p buf prod connection)
          buf)
     ;; Global sql-buffer
     (and (setq buf (default-value 'sql-buffer))
          (sql-buffer-live-p buf prod connection)
          buf)
     ;; Look thru each buffer
     (car (apply 'append
                 (mapcar (lambda (b)
                           (and (sql-buffer-live-p b prod connection)
                                (list (buffer-name b))))
                         (buffer-list)))))))


(setq sql-connection-alist
      '((nodo-3  (sql-product 'postgres)
                 (sql-server "nodo3.conabio.gob.mx")
                 (sql-port 8978)
                 (sql-database "deliveries")
                 (sql-user "postgres"))
        (local-deliveries (sql-product 'postgres)
                          (sql-server "localhost")
                          (sql-port 5432)
                          (sql-database "deliveries")
                          (sql-user "miguel"))))

(defun miguel/sql-connect (product connection)
  (setq sql-product product)
  (sql-connect connection))

(defun miguel/connect-node3 ()
  (interactive)
  (miguel/sql-connect 'postgres 'nodo-3))

(defun miguel/connect-deliveries-local ()
  (interactive)
  (miguel/sql-connect 'postgres 'local-deliveries))
