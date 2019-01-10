(defpackage :ca-file-format
  (:use :cl
	:cl-ppcre
	:split-sequence))
(in-package :ca-file-format)

;; FIXME: handling blank lines concatenated to a dot and test basic working.
(defun read-life-1.05 (stream)
  (flet ((read-header (s)
	   (scan-to-strings "\\#Life 1.05" (read-line s nil nil)))
	 (read-comment (s)
	   (scan-to-strings "\\#D(.*)" (read-line s nil nil)))
	 (read-init-state-line (s)
	   (loop :for c :across (read-line s nil "")
	      :collect (char= c #\*))))
    (let ((comment-strings nil)
	  (state-strings nil))
      (when (read-header stream)
	(loop :while (char= (peek-char nil stream) #\#)
	   :do (push (read-comment stream) comment-strings))
	(loop :for line = (read-line stream nil nil)
	   :while line
	   :do (push (read-init-state-line line) state-strings))
	(make-array (list (length state-strings)
			  (length (car state-strings)))
		    :initial-contents state-strings)))))


(defun read-rle-line (line full-length)
  "Decode run length encoding in the string LINE and return a list of lengths"
  (let ((run-lengths nil))
    (do-register-groups ((#'(lambda (str)
			      (if (string= str "")
				  1
				  (read-from-string str)))
			    len)
			 (#'(lambda (str)
			      (cond ((string= str "b") :dead)
				    ((string= str "o") :alive)
				    (t (error "unknown type"))))
			    type))
	("(\\d*)([bo])" line)
      (push (cons len type) run-lengths))
    (let ((match-len (loop :for run-len :in run-lengths :sum (car run-len))))
      (unless (zerop (- full-length match-len))
	(push (cons (- full-length match-len)
		    (if (eq (cdr (car run-lengths)) :dead)
			:alive
			:dead))
	      run-lengths)))
    (mapcan (lambda (run-len)
	      (make-list (car run-len)
			 :initial-element (eq (cdr run-len) :alive)))
	    run-lengths)))

(defun read-rle (stream)
  (register-groups-bind ((#'read-from-string x y))
      ("x[ ]*=(.*),[ ]*y[ ]*=(.*)" (read-line stream nil nil))
    (let ((rle-string (loop
			 :with rle-string-stream = (make-string-output-stream)
			 :for c = (read-char stream nil nil)
			 :while c
			 :until (char= c #\!)
			 :do (write-char c rle-string-stream)
			 :finally (return (get-output-stream-string
					   rle-string-stream)))))
      (make-array (list y x) ;; Array num-of-rows is x??
		  :initial-contents (mapcar (lambda (run-len-str)
					      (read-rle-line run-len-str x))
					    (split-sequence #\$ rle-string))))))
