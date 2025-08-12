;; Friendship Badges Contract
;; A minimal implementation for awarding and checking friendship badges

;; Store badges: Key -> (giver, receiver)
(define-map badges {giver: principal, receiver: principal} bool)

;; Error constants
(define-constant err-badge-exists (err u100))
(define-constant err-self-gift (err u101))

;; 1. Give a friendship badge
(define-public (give-badge (receiver principal))
  (begin
    (asserts! (not (is-eq tx-sender receiver)) err-self-gift)
    (asserts! (is-none (map-get? badges {giver: tx-sender, receiver: receiver})) err-badge-exists)
    (map-set badges {giver: tx-sender, receiver: receiver} true)
    (ok true)
  )
)

;; 2. Check if badge exists
(define-read-only (has-badge (giver principal) (receiver principal))
  (ok (is-some (map-get? badges {giver: giver, receiver: receiver})))
)


