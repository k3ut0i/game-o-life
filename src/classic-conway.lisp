(defpackage :classic-conway
  (:use :cl)
  (:export :step-life))
(in-package :classic-conway)

(defun cell-next-state (cell-type neighbors)
  (declare (type boolean cell-type)
	   (type list neighbors ))
  (let ((alive-neighbors (loop :for n :in neighbors :count n)))
    (if cell-type
	(case alive-neighbors
	  ((0 1) nil)
	  ((2 3) t)
	  (otherwise nil))
	(= alive-neighbors 3))))

(defun get-neighbors (array x y)
  (declare (type (array boolean) array)
	   (type fixnum x y))
  (let ((neighbor-indices (list (cons (1+ x) (1+ y))
				(cons (1+ x) y)
				(cons (1+ x) (1- y))
				(cons x (1- y))
				(cons (1- x) (1- y))
				(cons (1- x) y)
				(cons (1- x) (1+ y))
				(cons x (1+ y)))))
    (mapcar (lambda (index)
	      (aref array (car index) (cdr index)))
	    (remove-if-not (lambda (index)
			     (array-in-bounds-p array (car index) (cdr index)))
			   neighbor-indices))))

(defun step-life (state)
  "Step the STATE of life using conway rules."
  (declare (type (array boolean) state))
  (let ((next-life (make-array (array-dimensions state)
			       :element-type 'boolean)))
    (destructuring-bind (width height)
	(array-dimensions state)
      (dotimes (j height next-life)
	(dotimes (i width)
	  (setf (aref next-life i j)
		(cell-next-state (aref state i j)
				 (get-neighbors state i j))))))))
