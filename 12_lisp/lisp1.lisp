; AoC Day12 Part1
(defun check (s y)
  ;(write-line s)
  (let ((cnts '())
        (cnt 0))
    (loop for c across s
          do (if (char= c #\#)
               (incf cnt)
               (when (> cnt 0)
                 (push (write-to-string cnt) cnts)
                 (setf cnt 0))))
    (if (> cnt 0)
      (push (write-to-string cnt) cnts))
    ;(write-line (write-to-string cnts))
    (let ((z (format nil "~{~a~^,~}" (reverse cnts))))
      (if (string= z y)
        1
        0))))

(defun dfs (s x y)
  (if (= (length s) (length x))
    (check s y)
    (let ((res 0))
      (when (not (char= (elt x (length s)) #\#))
        (incf res (dfs (concatenate 'string s ".") x y)))
      (when (not (char= (elt x (length s)) #\.))
        (incf res (dfs (concatenate 'string s "#") x y)))
      res)))

(defun solve (s)
  (let ((x (subseq s 0 (position #\Space s)))
        (y (subseq s (1+ (position #\Space s)))))
    (dfs "" x y)))

(let ((ans 0))
  (loop for s = (read-line *standard-input* nil nil)
        while s
        do (incf ans (solve s)))
  (write-line (write-to-string ans)))
