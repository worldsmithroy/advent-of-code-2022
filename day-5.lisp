(ql:quickload :cl-ppcre)

;; Core Logic

(defun move-crate (crates from to)
	(push (pop (nth from crates)) (nth to crates)))

(defun move-crates (crates count from to)
	(dotimes (move count) (move-crate crates (- from 1) (- to 1))))

(defun top-crates (crates)
	(apply #'concatenate 'string (mapcar #'car crates)))

;; Loading/Parsing

;; Loading/Parsing Board Data

(defun split-board-row (board-row-data)
	(cl-ppcre:all-matches-as-strings "(\\[\\w\\]|\\s{3}){1}(\\s|$){1}" board-row-data))

(defun tokenize-board-element (element)
	(car (cl-ppcre:all-matches-as-strings "\\w+" element)))

(defun tokenize-board-row (board-row-data)
	(map 'list
		 #'tokenize-board-element
		 (split-board-row board-row-data)))

(defun tokenize-board (board-data)
	(map 'list
		 #'tokenize-board-row
		 (reverse (cdr (reverse (cl-ppcre:split "\\n" board-data))))))

(defun parse-board (board-data)
	(map 'list
		 #'(lambda (row) (remove nil row))
		 (map 'list
			 #'(lambda (row) (remove "   " row :test #'equal))
			 (apply
				#'mapcar
				#'list
				(tokenize-board board-data)))))

;; Loading/Parsing Move Data

(defun parse-move-row (move-row-data)
	(map 'list
		 #'parse-integer
		 (cl-ppcre:all-matches-as-strings "\\d+" move-row-data)))

(defun parse-moves (move-data)
	(map 'list
		 #'parse-move-row
		 (cl-ppcre:split "\\n" move-data)))

;; Bippity Boppity Boo

(defun reorganize-crates (filename)
	(let* (
		(file-data		(cl-ppcre:split "\\n{2}" (uiop:read-file-string filename)))
		(crate-stack	(parse-board (nth 0 file-data)))
		(move-list 		(parse-moves (nth 1 file-data)))
		)
		(progn
			(map 'nil
				 #'(lambda (move-row) (apply #'move-crates crate-stack move-row))
				 move-list)
			(top-crates crate-stack))))