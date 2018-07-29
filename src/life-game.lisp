(in-package #:life-game)

(defparameter *dead* "*")
(defparameter *live* "O")
(defparameter *table* (loop for j from 0 to 19
						 collect (create-line 20 *dead*)))

(defun create-line (len sel-val)
  (loop for i from 0 to (1- len)
	 collect (format nil sel-val)))

(defun sel-positionp (table x y)
  (cond ((and (> (length table) y) (> (length (car table)) x))
		 (nth x (nth y table)))))

(defun get-sel (table x y)
  (cond ((sel-positionp table x y)
		 (nth x (nth y table)))))

;;; 代入ではなく、テーブルそのものを返すようにしたい。
(defun set-sel (table x y val)
  (cond ((sel-positionp table x y)
		 (setf (nth x (nth y table)) val))))

(defun random-set-sels (table)
  (let* ((num (* 2 (* (length table) 0.6)))
		 (len-x (length (car table)))
		 (len-y (length table))
		 (random-sels (loop for i from 1 to num
						 collect (cons (random len-x) (random len-y)))))
	(mapcar #'(lambda (x)
				(set-sel table (car x) (cdr x) *live*))
			random-sels)
	random-sels))

(defun get-sel-around (table x y)
  (let* ((sel-around (mapcan #'(lambda (x) x)
							 (loop for i from (1- x) to (1+ x)
								collect (loop for j from (1- y) to (1+ y)
										   collect (cons i j)))))
		 (sel-around-without-me-and-outrange
		  (remove-if #'(lambda (z)
						 (or (<= (length table)
								 (car z))
							 (<= (length (car table))
								 (cdr z))
							 (>  0
								 (car z))
							 (>  0
								 (cdr z))
							 (and (= (car z) x) (= (cdr z) y))
							 ))
					 sel-around)))
	sel-around-without-me-and-outrange))

(defun sel-fate (table x y)
  (let* ((around-list (get-sel-around table x y))
		(around-sel-list
		 (mapcar #'(lambda (z) (get-sel table (car z) (cdr z)))
				 around-list))
		 (cnt (count "O" around-sel-list :test #'equal)))
	(cond ((<= cnt 1)
		   (set-sel table x y *dead*))
		  ((= cnt 3)
		   (set-sel table x y *live*))
		  ((= cnt 4)
		   (set-sel table x y *dead*))
		  (t (set-sel table x y (get-sel table x y))))))

(defun check-table-sels-fate (table)
  (let ((all-position-list
		 (mapcan #'(lambda (x) x) (loop for i from 0 to (1- (length table))
									 collect (loop for j from 0 to (1- (length (car table)))
												collect (cons i j))))))
	(mapcar #'(lambda (x) (sel-fate table (car x) (cdr x))) all-position-list)))

(defun main-loop ()
  (setf *table* (loop for j from 0 to 19
						 collect (create-line 20 *dead*)))
  (random-set-sels *table*)
  (loop repeat 100
	   do (print (check-table-sels-fate *table*))))
