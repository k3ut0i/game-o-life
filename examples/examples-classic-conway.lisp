(defpackage :examples-classic-conway
  (:use :cl
	:uiop/run-program
	:classic-conway
	:classic-conway/input-states
	:image-utils))

(in-package :examples-classic-conway)

(defvar +convert-prog-path+ "/usr/bin/convert")
(defvar +convert-prog-options+ '("-delay" "100"  ;; Delay b/w frames
				 "-loop" "0"     ;; Gif looping
				 "pbm:-"
				 "-resize" "100x100"
				 "gif:-"))

(defun life-for-n-gen (input-state num-gen output-stream)
  (loop
     :with state = input-state
     :repeat num-gen
     :do (write-array-to-pbm state output-stream)
     :do (setq state (step-life state))))

(defun gen-beacon ()
  (with-open-file (gif-stream "beacon.gif"
			  :direction :output
			  :if-exists :supersede)
    (let ((pbm-stream (make-string-output-stream)))
      (life-for-n-gen +beacon+ 10 pbm-stream)
      (convert-to-gif (make-string-input-stream
		       (get-output-stream-string pbm-stream))
		      gif-stream))))

(defun gen-all ()
  (gen-beacon))

(defun convert-to-gif (pbm-input-stream gif-output-stream)
  (run-program
   (cons +convert-prog-path+ +convert-prog-options+)
   :input pbm-input-stream
   :output gif-output-stream))
