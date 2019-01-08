(defpackage :test-classic-conway
  (:use :cl
	:rt
	:classic-conway
	:utils))

(in-package :test-classic-conway)

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

(defun double-identity (fn initial-state)
  (array-equal (funcall fn (funcall fn initial-state)) initial-state))

(deftest "blinker"
    (double-identity #'step-life +blinker+)
  t)

(deftest "toad"
    (double-identity #'step-life +toad+)
  t)
