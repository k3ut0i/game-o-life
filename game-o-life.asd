(defsystem :game-o-life
  :version "0.1.0"
  :components ((:module "src"
			:components ((:file "utils")
				     (:file "image-utils")
				     (:file "classic-conway"))))
  :in-order-to ((test-op (load-op :game-o-life/test)))
  :perform (test-op (o c) (symbol-call :test-classic-conway :do-tests)))

(defsystem :game-o-life/test
  :version "0.1.0"
  :depends-on (:rt :game-o-life)
  :components ((:module "t"
			:components ((:file "test-classic-conway")))))
