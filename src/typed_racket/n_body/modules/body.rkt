#lang typed/racket/base

(require (for-syntax racket/base)
	 racket/flonum)

(provide make-body)

(define-type Body (Vector Flonum Flonum Flonum Flonum Flonum Flonum Flonum))

;; Changed to define to allow type-checking
(: make-body :  Flonum Flonum Flonum Flonum Flonum Flonum Flonum -> Body)
(define (make-body x y z vx vy vz m)
  (vector x y z vx vy vz m))

(define-syntax-rule (deffield n getter setter)
  (begin (define-syntax-rule (getter b) (vector-ref b n))
         (define-syntax-rule (setter b x) (vector-set! b n x))))

(deffield 0 body-x set-body-x!)
(deffield 1 body-y set-body-y!)
(deffield 2 body-z set-body-z!)
(deffield 3 body-vx set-body-vx!)
(deffield 4 body-vy set-body-vy!)
(deffield 5 body-vz set-body-vz!)
(deffield 6 body-mass set-body-mass!)
