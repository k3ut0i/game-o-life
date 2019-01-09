(defpackage :classic-conway/input-states
  (:use :cl)
  (:export :+blinker+
	   :+toad+
	   :+beacon+))

(in-package :classic-conway/input-states)

(defvar +blinker+ (make-array '(5  5)
			      :initial-contents
			      '((nil nil nil nil nil)
				(nil nil nil nil nil)
				(nil t t t nil)
				(nil nil nil nil nil)
				(nil nil nil nil nil))))

(defvar +toad+ (make-array '(6 6)
			   :initial-contents
			   '((nil nil nil nil nil nil)
			     (nil nil nil nil nil nil)
			     (nil nil t t t nil)
			     (nil t t t nil nil)
			     (nil nil nil nil nil nil)
			     (nil nil nil nil nil nil))))

(defvar +beacon+ (make-array '(6 6)
			     :initial-contents
			     '((nil nil nil nil nil nil)
			       (nil t t nil nil nil)
			       (nil t t nil nil nil)
			       (nil nil nil t t nil)
			       (nil nil nil t t nil)
			       (nil nil nil nil nil nil))))
