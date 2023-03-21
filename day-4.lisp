(load "file-parsing.lisp")
(ql:quickload :serapeum)

(defun fits-in? (zone-1 zone-2)
	(and
		(>= (nth 0 zone-1) (nth 0 zone-2))
		(<= (nth 1 zone-1) (nth 1 zone-2))))

(defun overlaps? (zone-1 zone-2)
	(or (fits-in? zone-1 zone-2) (fits-in? zone-2 zone-1)))

(defun zones-overlap (zone-set)
	(overlaps? (nth 0 zone-set) (nth 1 zone-set)))

(defun count-redundancy (zone-assignments)
	(count-if #'zones-overlap zone-assignments))

(defun load-assignments-file (assignments-file)
	(map 'list
		 #'(lambda (data-row) (serapeum:batches data-row 2))
		 (load-chunked-numeric-data-from-file assignments-file "\\n")))

(defun check-assignments-for-redundancy (assignments-file)
	(count-redundancy (load-assignments-file assignments-file)))
