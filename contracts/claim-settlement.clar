;; Claim Settlement Contract

(define-map claims
  { claim-id: uint }
  {
    policy-id: uint,
    amount: uint,
    status: (string-ascii 20),
    created-at: uint,
    settled-at: (optional uint)
  }
)

(define-map policy-claims
  { policy-id: uint }
  { claim-ids: (list 100 uint) }
)

(define-data-var claim-id-nonce uint u0)

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u403))
(define-constant ERR_NOT_FOUND (err u404))
(define-constant ERR_INVALID_STATUS (err u400))

(define-read-only (get-claim (claim-id uint))
  (map-get? claims { claim-id: claim-id })
)

(define-read-only (get-policy-claims (policy-id uint))
  (map-get? policy-claims { policy-id: policy-id })
)

(define-public (file-claim (policy-id uint) (amount uint))
  (let
    ((new-claim-id (+ (var-get claim-id-nonce) u1))
     (policy-claim-list (default-to { claim-ids: (list) } (map-get? policy-claims { policy-id: policy-id }))))
    (map-set claims
      { claim-id: new-claim-id }
      {
        policy-id: policy-id,
        amount: amount,
        status: "pending",
        created-at: block-height,
        settled-at: none
      }
    )
    (map-set policy-claims
      { policy-id: policy-id }
      { claim-ids: (unwrap! (as-max-len? (append (get claim-ids policy-claim-list) new-claim-id) u100) ERR_UNAUTHORIZED) }
    )
    (var-set claim-id-nonce new-claim-id)
    (ok new-claim-id)
  )
)

(define-public (approve-claim (claim-id uint))
  (let
    ((claim (unwrap! (map-get? claims { claim-id: claim-id }) ERR_NOT_FOUND)))
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (asserts! (is-eq (get status claim) "pending") ERR_INVALID_STATUS)
    (ok (map-set claims
      { claim-id: claim-id }
      (merge claim
        {
          status: "approved",
          settled-at: (some block-height)
        }
      )
    ))
  )
)

(define-public (reject-claim (claim-id uint))
  (let
    ((claim (unwrap! (map-get? claims { claim-id: claim-id }) ERR_NOT_FOUND)))
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (asserts! (is-eq (get status claim) "pending") ERR_INVALID_STATUS)
    (ok (map-set claims
      { claim-id: claim-id }
      (merge claim
        {
          status: "rejected",
          settled-at: (some block-height)
        }
      )
    ))
  )
)

(define-read-only (get-total-approved-claims (policy-id uint))
  (match (get-policy-claims policy-id)
    claims (fold + (map get-approved-claim-amount (get claim-ids claims)) u0)
    u0
  )
)

(define-private (get-approved-claim-amount (claim-id uint))
  (match (get-claim claim-id)
    claim (if (is-eq (get status claim) "approved") (get amount claim) u0)
    u0
  )
)

