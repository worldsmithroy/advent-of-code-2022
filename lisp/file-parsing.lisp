(ql:quickload :cl-strings)
(ql:quickload :cl-ppcre)

(defun partition-data (raw-data data-separator)
	(cl-ppcre:split data-separator raw-data))

(defun split-data-into-numbers (raw-data)
	(map 'list
		 #'cl-strings:parse-number
		 (cl-ppcre:all-matches-as-strings "\\d+" raw-data)
		))

(defun load-line-by-line-data-from-file (filename)
	(cl-ppcre:split "\\n" (uiop:read-file-string filename)))

(defun load-chunked-numeric-data-from-file (filename data-separator)
	(map 'list
		 #'split-data-into-numbers
		 (partition-data (uiop:read-file-string filename) data-separator)))

(defun load-text-data-from-file (filename)
	(map 'list
		 #'(lambda (text-line) (cl-ppcre:all-matches-as-strings "\\w+" text-line))
		 (load-line-by-line-data-from-file filename)
		 ))

(defun parse-file-content (filename data-separator data-structure)
	(map 'list
		 #'(lambda (text-block) (cl-ppcre:all-matches-as-strings data-structure text-block))
		 (cl-ppcre:split data-separator (uiop:read-file-string filename))))