(load "file-parsing.lisp")
(ql:quickload :serapeum)

(defparameter *beats-table* (serapeum:dict
	:rock :scissors
	:scissors :paper
	:paper :rock
	))

(defparameter *score-table* (serapeum:dict
	:rock 1
	:paper 2
	:scissors 3
	))

(defparameter *guide-mapping* (serapeum:dict
	"A" :rock
	"B" :paper
	"C" :scissors
	"X" :rock
	"Y" :paper
	"Z" :scissors
	))

(defun calculate-winner (player opponent)
	(cond
		((eq player opponent) 1)
		((eq opponent (gethash player *beats-table*)) 2)
		(t 0)
		))

(defun calculate-score (player opponent)
	(+
		(* 3 (calculate-winner player opponent))
		(gethash player *score-table*)
		))

(defun score-row (data-row)
	(calculate-score (gethash (nth 1 data-row) *guide-mapping*) (gethash (nth 0 data-row) *guide-mapping*)))

(defun score-guide (guide-filename)
	(reduce
		#'+
		(map 'list
			 #'(lambda (row) (score-row row))
			 (load-text-data-from-file guide-filename)
			 )
		))

;; Phase 2

(defun calculate-strategic-move (opponent strategy)
	(cond
		((equal strategy "X") (gethash opponent *beats-table*)) ;; Planned Loss
		((equal strategy "Z") (gethash opponent (serapeum:flip-hash-table *beats-table*))) ;; Planned Win
		(t opponent)))

(defun score-strategic-row (data-row)
	(let (
		(opponent-move		(gethash (nth 0 data-row) *guide-mapping*))
		)
		(calculate-score (calculate-strategic-move opponent-move (nth 1 data-row)) opponent-move)))

(defun score-strategic-guide (guide-filename)
	(reduce
		#'+
		(map 'list
			 #'(lambda (row) (score-strategic-row row))
			 (load-text-data-from-file guide-filename)
			 )
		))