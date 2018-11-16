#lang typed/racket/base

(require racket/flonum)

(require/typed/check "system.rkt"
  [+solar-mass+ Flonum]
  [+dt+ Flonum]
  [*system* (Vector Body Body Body Body Body)]
  [*system-size* Integer])

(provide energy)

(define (energy)
  (let loop-o : Flonum ([o : Integer 0] [e : Flonum 0.0]) 
       (if (= o *system-size*)
           e
           (let* ([o1 (vector-ref *system* o)]
                  [e (fl+ e (fl* (fl* 0.5 (body-mass o1))
                                 (fl+ (fl+ (fl* (body-vx o1) (body-vx o1))
                                           (fl* (body-vy o1) (body-vy o1)))
                                      (fl* (body-vz o1) (body-vz o1)))))])
             (let loop-i : Flonum ([i : Integer (+ o 1)] [e : Flonum e])
                  (if (= i *system-size*)
                      (loop-o (+ o 1) e)
                      (let* ([i1   (vector-ref *system* i)]
                             [dx   (fl- (body-x o1) (body-x i1))]
                             [dy   (fl- (body-y o1) (body-y i1))]
                             [dz   (fl- (body-z o1) (body-z i1))]
                             [dist (flsqrt (fl+ (fl+ (fl* dx dx) (fl* dy dy)) (fl* dz dz)))]
                             [e    (fl- e (fl/ (fl* (body-mass o1) (body-mass i1)) dist))])
                        (loop-i (+ i 1) e))))))))


