;; Tuples are an early simple data structure for holding multiple values. 
;; *You should probably not be using them*.
;; Values are indexed from 1 and there is little error detection
;;   apart from range checks.
;;
;; ```
;;  > (define x (list->tuple '(a b c)))
;;  > (ref x 1)
;;  'a
;;  > (size x)
;;  3
;;  > (equal? x (tuple 'a 'b 'c))
;;  #true
;; ```

(define-library (owl tuple)

   (export tuple?
      list->tuple tuple->list
      read-tuple)

   (import
      (owl defmac)
      (owl list-extra)
      (owl list) 
      (owl math) 
      (only (owl syscall) error))

   (begin
      (define (tuple? x) 
         (eq? (type x) type-tuple))

      (define (list->tuple lst)
         (let ((l (length lst)))
            (if (eq? (type l) type-fix+)
               (listuple 2 l lst)
               (error "list does not fit a tuple: length " l))))

      (define (read-tuple tuple pos lst)
         (if (= pos 0)
            lst  
            (read-tuple tuple (- pos 1)
               (cons (ref tuple pos) lst))))

      (define (tuple->list tuple)
         (read-tuple tuple (size tuple) null))))

