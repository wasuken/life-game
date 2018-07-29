;; (require \'asdf)
 
 (in-package :cl-user)
 (defpackage life-game-test-asd
 (:use :cl :asdf))
 (in-package :life-game-test-asd)
 
 (defsystem life-game-test
 :depends-on (:life-game)
 :version "1.0.0"
 :author "wasu"
 :license "MIT"
 :components ((:module "t" :components ((:file "life-game-test"))))
 :perform (test-op :after (op c)
 (funcall (intern #.(string :run) :prove) c)))

