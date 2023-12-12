; AoC Day12 Part2
(defun cat-string (s n)
  (if (= 1 n)
    s
    (format nil "~a?~a" s (cat-string s (1- n)))))

(defun get-string (s)
  (let ((x (subseq s 0 (position #\Space s))))
    (cat-string x 5)))

(defun cat-int-array(a n)
  (loop repeat n
        append a into res
        finally (return res)))

(defun get-int-array (s)
  (let ((z (subseq s (1+ (position #\Space s))))
        (cur 0)
        (res '()))
    (loop for c across z do
          (if (digit-char-p c)
            (setf cur (+ (* cur 10) (- (char-code c) (char-code #\0))))
            (when (/= cur 0)
              (push cur res)
              (setf cur 0))))
    (if (/= cur 0)
      (push cur res))
    (cat-int-array (reverse res) 5)))

(defun solve (s)
  (let ((x (get-string s))
        (y (get-int-array s)))
    ;(write-line (write-to-string x))
    ;(write-line (write-to-string y))
    (let ((n (length x))
          (m (length y)))
      (let ((dp (make-array `(,(1+ n), (1+ m)) :initial-element 0)))
        (incf (aref dp 0 0))
        (dotimes (i n)
          (dotimes (j m)
            (if (not (char= (aref x i) #\#))
              (incf (aref dp (1+ i) j) (aref dp i j)))
            (let ((ni (+ i (nth j y))))
              (if
                (and
                  (or
                    (= ni n)
                    (and (< ni n) (char/= (aref x ni) #\#)))
                  (not (find #\. (subseq x i ni))))
                (incf (aref dp (min n (1+ ni)) (1+ j)) (aref dp i j)))))
          (if (not (char= (aref x i) #\#))
            (incf (aref dp (1+ i) m) (aref dp i m))))
        (aref dp n m)))))

(let ((ans 0))
  (loop for s = (read-line *standard-input* nil nil)
        while s
        do (incf ans (solve s)))
  (write-line (write-to-string ans)))
