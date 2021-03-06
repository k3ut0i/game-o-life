(defpackage :examples-classic-conway
  (:use :cl
	:uiop/run-program
	:classic-conway
	:classic-conway/input-states
	:ca-file-format
	:image-utils))

(in-package :examples-classic-conway)

(defvar +convert-prog-path+ "/usr/bin/convert")
(defvar +convert-prog-options+ '("-delay" "10"  ;; Delay b/w frames
				 "-loop" "0"     ;; Gif looping
				 "pbm:-"
				 "-rotate" "90"
				 "gif:-"))

(defun life-for-n-gen (input-state num-gen output-stream)
  (loop
     :with state = input-state
     :repeat num-gen
     :do (write-array-to-pbm state output-stream)
     :do (setq state (step-life state))))


(defun gen-image (input-state num-gen output-file-name)
  (with-open-file (gif-stream output-file-name
			      :direction :output
			      :if-exists :supersede)
    (let ((pbm-stream (make-string-output-stream)))
      (life-for-n-gen input-state num-gen pbm-stream)
      (convert-to-gif (make-string-input-stream
		       (get-output-stream-string pbm-stream))
		      gif-stream))))

(defun gen-gosper ()
  (with-open-file (s "patterns/gosperglidergun.rle")
    (gen-image (read-rle s 10 10) 100 "gosperglidergun.gif")))

(defun gen-all ()
  (gen-image +beacon+ 10 "beacon.gif")
  (gen-image +toad+ 10 "toad.gif")
  (gen-image +blinker+ 10 "blinker.gif")
  (gen-gosper))

(defun convert-to-gif (pbm-input-stream gif-output-stream)
  (run-program
   (cons +convert-prog-path+ +convert-prog-options+)
   :input pbm-input-stream
   :output gif-output-stream))
