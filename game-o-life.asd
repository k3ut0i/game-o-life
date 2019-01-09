(defsystem :game-o-life
  :version "0.1.0"
  :components ((:module "src"
			:components ((:file "utils")
				     (:file "image-utils")
				     (:file "classic-conway"))))
  :in-order-to ((test-op (load-op :game-o-life/test)))
  :perform (test-op (o c) (symbol-call :test-classic-conway :do-tests)))

(defsystem :game-o-life/examples
  :version "0.1.0"
  :depends-on (:game-o-life)
  :components ((:module "examples"
			:components ((:file "conway-input-states")
				     (:file "examples-classic-conway"))))
  :perform (load-op (o c) (symbol-call :examples-classic-conway :gen-all)))

(defsystem :game-o-life/test
  :version "0.1.0"
  :depends-on (:rt :game-o-life :game-o-life/examples :uiop)
  :components ((:module "t"
			:components ((:file "test-classic-conway")))))
