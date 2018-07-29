;; (require \'asdf)
 
 (in-package :cl-user)
 (defpackage life-game-asd
 (:use :cl :asdf))
 (in-package :life-game-asd)
 
 (defsystem :life-game
 :version "1.0.0"
 :author "wasu"
 :license "MIT"
 :components ((:file "package")
 (:module "src" :components ((:file "life-game")))))

