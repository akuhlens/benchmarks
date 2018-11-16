#lang racket/base

;; The Computer Language Benchmarks Game
;; http://benchmarksgame.alioth.debian.org/
;;
;; Imperative-style implementation based on the SBCL implementation by
;; Patrick Frankenberger and Juho Snellman, but using only native Scheme
;; idioms like 'named let' and 'do' special form.
;;
;; Contributed by Anthony Borla, then converted for Racket
;; by Matthew Flatt and Brent Fulgham
;; Made unsafe and optimized by Sam TH
;;
;;; Here we actively choose to not use racket racket/fixnum. Use of
;;; generic numeric ops is disadvantage for racket but there is no
;;; safe version of fixnum operations that avoids the overhead of
;;; contracts, and we are only interested in comparing safe code.  The
;;; racket/fixnum safe operations are generally no faster than using
;;; generic primitives like +. (According to the documentation)
#|
Correct output N = 1000 is

-0.169075164
-0.169087605
|#

(require racket/flonum)

(require "system.rkt"
         "momentum.rkt"
         "energy.rkt")

(define (advance)
  (let loop-o ([o 0])
    (unless (= o *system-size*)
      (let* ([o1 (vector-ref *system* o)])
        (let loop-i ([i  (+ o 1)]
                     [vx (body-vx o1)]
                     [vy (body-vy o1)]
                     [vz (body-vz o1)])
          (if (< i *system-size*)
              (let* ([i1    (vector-ref *system* i)]
                     [dx    (fl- (body-x o1) (body-x i1))]
                     [dy    (fl- (body-y o1) (body-y i1))]
                     [dz    (fl- (body-z o1) (body-z i1))]
                     [dist2 (fl+ (fl+ (fl* dx dx) (fl* dy dy)) (fl* dz dz))]
                     [mag   (fl/ +dt+ (fl* dist2 (flsqrt dist2)))]
                     [dxmag (fl* dx mag)]
                     [dymag (fl* dy mag)]
                     [dzmag (fl* dz mag)]
                     [om (body-mass o1)]
                     [im (body-mass i1)])
                (set-body-vx! i1 (fl+ (body-vx i1) (fl* dxmag om)))
                (set-body-vy! i1 (fl+ (body-vy i1) (fl* dymag om)))
                (set-body-vz! i1 (fl+ (body-vz i1) (fl* dzmag om)))
                (loop-i (+ i 1)
                        (fl- vx (fl* dxmag im))
                        (fl- vy (fl* dymag im))
                        (fl- vz (fl* dzmag im))))
              (begin (set-body-vx! o1 vx)
                     (set-body-vy! o1 vy)
                     (set-body-vz! o1 vz)
                     (set-body-x! o1 (fl+ (body-x o1) (fl* +dt+ vx)))
                     (set-body-y! o1 (fl+ (body-y o1) (fl* +dt+ vy)))
                     (set-body-z! o1 (fl+ (body-z o1) (fl* +dt+ vz)))))))
      (loop-o (+ o 1)))))

(define (main)
  (let ([n (read)])
    (offset-momentum)
    (printf "~a\n" (real->decimal-string (energy) 9))
    (for ([i (in-range n)]) (advance))
    (printf "~a\n" (real->decimal-string (energy) 9))))

(time (main))
