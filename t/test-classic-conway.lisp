(defpackage :test-classic-conway
  (:use :cl
	:rt
	:classic-conway
	:classic-conway/input-states
	:utils))

(in-package :test-classic-conway)

(defun double-identity (fn initial-state)
  (array-equal (funcall fn (funcall fn initial-state)) initial-state))

(deftest "blinker"
    (double-identity #'step-life +blinker+)
  t)

(deftest "toad"
    (double-identity #'step-life +toad+)
  t)

(deftest "beacon"
    (double-identity #'step-life +beacon+)
  t)
