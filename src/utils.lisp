(defpackage :utils
  (:use :cl)
  (:export :array-equal))

(in-package :utils)

(defun array-equal (array1 array2)
  (and (equal (array-dimensions array1)
	      (array-dimensions array2))
       (loop :for i :below (array-total-size array1)
	  :always (equal (row-major-aref array1 i)
			 (row-major-aref array2 i)))))
