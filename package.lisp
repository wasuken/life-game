;; (in-package :cl-user)
(defpackage life-game
  (:use :cl)
  (:export :get-sel-around :check-table-sels-fate
		   :*dead* :*live* :*table*))
