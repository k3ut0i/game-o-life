(defpackage :image-utils
  (:use :cl)
  (:export :write-array-to-pbm))
(in-package :image-utils)

(defun write-array-to-pbm (image-array stream)
  "Write an bool array IMAGE-ARRAY in pbm format to STREAM."
  (check-type image-array (array boolean))
  (destructuring-bind (width height)
      (array-dimensions image-array)
    (format stream "P1~%~A ~A~%" width height)
    (dotimes (j height)
      (dotimes (i width)
	(format stream "~A " (if (aref image-array i j) 1 0)))
      (princ #\Newline stream))))
