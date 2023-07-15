(load "file-parsing.lisp")

(defun tally-up-calories (calorie-set)
	(map 'list
		 #'(lambda (calorie-collection) (reduce #'+ calorie-collection))
		 calorie-set))

(defun max-calorie (calorie-set)
	(apply #'max (tally-up-calories calorie-set)))

(defun find-max-calories-in-inventory (inventory-filename)
	(let (
		(inventory 		(load-chunked-numeric-data-from-file inventory-filename "\\n{2}"))
		)
		(max-calorie inventory)))

(defun count-top-calories (top-calorie-count calorie-set)
	(reduce #'+
		(subseq (sort (tally-up-calories calorie-set) #'>) 0 top-calorie-count)
		))

(defun find-top-calories-in-inventory (top-entry-count inventory-filename)
	(let (
		(inventory 		(load-chunked-numeric-data-from-file inventory-filename "\\n{2}"))
		)
		(count-top-calories top-entry-count inventory)))