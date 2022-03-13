#lang racket
(require "ast.rkt")
(provide max-stack-size)

(module+ test (require rackunit))

;; max-stack-size : Expr -> Natural
;; Compute the maximum number of elements pushed on the stack
;; when executing the compiled code for the given expression.

(module+ test
  (check-equal? (max-stack-size (Bool #t)) 0)
  (check-equal? (max-stack-size (Var 'x)) 0)
  (check-equal? (max-stack-size (Prim0 'read-byte)) 0)
  (check-equal? (max-stack-size (Prim1 'add1 (Int 5))) 0)
  (check-equal? (max-stack-size (Let 'x (Int 5) (Var 'x))) 1)
  (check-equal? (max-stack-size (Let 'x (Let 'y (Int 5) (Var 'y)) (Var 'x))) 1)  
  (check-equal? (max-stack-size (Prim2 '+ (Int 5) (Int 4))) 1))
   
(define (max-stack-size e)
  ;; TODO: implement this function
  0
  (match e
    [(Int i)            0]
    [(Bool b)           0]
    [(Char c)           0]
    [(Eof)              0]
    [(Var x)            0]
    [(Prim0 p)          0]
    [(Prim1 p e)        (max 0 (max-stack-size e))]
    [(Prim2 p e1 e2)    (max 1 (max-stack-size e1) (max-stack-size e2))]
    [(If e1 e2 e3)      (max (max-stack-size e1) (max-stack-size e2) (max-stack-size e3))]
    [(Begin e1 e2)      (max 1 (max-stack-size e1) (max-stack-size e2))]
    [(Let x e1 e2)      (max 1 (max-stack-size e1) (max-stack-size e2))])
  )