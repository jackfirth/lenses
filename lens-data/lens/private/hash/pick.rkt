#lang racket/base

(require racket/contract
         racket/list
         lens/private/base/main
         lens/private/util/rest-contract
         "../hash/join-hash.rkt"
         "../util/immutable.rkt"
         "ref.rkt")

(module+ test
  (require rackunit lens/private/test-util/test-lens))

(provide
 (contract-out
  [hash-pick-lens (rest-> any/c (lens/c immutable-hash? immutable-hash?))]))


(define (hash-ref-lens-and-key k)
  (list k (hash-ref-lens k)))

(define (hash-pick-lens . ks)
  (apply lens-join/hash
         (append-map hash-ref-lens-and-key ks)))

(module+ test
  (check-lens-view (hash-pick-lens 'a 'c) (hash 'a 1 'b 2 'c 3)
                   (hash 'a 1 'c 3))
  (check-lens-set (hash-pick-lens 'a 'c) (hash 'a 1 'b 2 'c 3) (hash 'a 4 'c 5)
                  (hash 'a 4 'b 2 'c 5)))
