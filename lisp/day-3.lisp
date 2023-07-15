(ql:quickload :cl-ppcre :serapeum)

(load "file-parsing.lisp")

(defparameter *content-types* '(
	"a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
	"A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
	))

(defun split-contents (rucksack)
	(let* (
		(rucksack-contents		(cl-ppcre:all-matches-as-strings "\\w" rucksack))
		(rucksack-size			(length rucksack-contents))
		(compartment-size		(/ rucksack-size 2))
		)
		(list (subseq rucksack-contents 0 compartment-size) (subseq rucksack-contents compartment-size))
	))

(defun common-contents (collection-1 collection-2)
	(remove-duplicates (intersection collection-1 collection-2 :test #'equal) :test #'equal))

(defun common-rucksack-contents (rucksack)
	(let (
		(compartment-1		(nth 0 (split-contents rucksack)))
		(compartment-2		(nth 1 (split-contents rucksack)))
		)
		(car (common-contents compartment-1 compartment-2))
	))

(defun prioritize-pack (rucksack)
	(+ 1 (position rucksack *content-types* :test #'equal)))

(defun score-packs (packlist)
	(reduce
		#'+
		(map 'list
			 #'prioritize-pack
			 (map 'list #'common-rucksack-contents packlist)
			 )))

(defun score-pack-file (filename)
	(score-packs (load-line-by-line-data-from-file filename)))

(defun find-badge (rucksack-collection)
	(car (reduce #'common-contents rucksack-collection)))

(defun priotize-pack-group (pack-group)
	(prioritize-pack (find-badge pack-group)))

(defun score-pack-badges (packlist group-size)
	(reduce
		#'+
		(map 'list
			 #'priotize-pack-group
			 (serapeum:batches packlist group-size))))

(defun score-pack-badge-file (filename)
	(score-pack-badges (parse-file-content filename "\\n" "\\w") 3))