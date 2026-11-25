# GO JATRA Captain App — Feature Specification

## Purpose

Build an original rider/driver ("Captain") app for GO JATRA. It should help a Captain safely go online, receive requests, decide whether to accept, complete rides, track earnings, receive support, and maintain required documents.

This brief uses public, high-level industry patterns as reference only. It must not copy another company’s brand, wording, screens, assets, or undisclosed product behavior.

## Product principles

1. **Safety before speed.** Captain controls must be usable while parked; never require dense reading while driving.
2. **Upfront clarity.** Show pickup distance, trip distance, estimated duration, vehicle/service type, and estimated payout before acceptance.
3. **Intentional acceptance.** Use swipe-to-accept to prevent accidental trip acceptance.
4. **Transparent earnings.** Separate trip fare, incentive, toll/adjustment, cash collected, and final payout.
5. **Low-network resilience.** Clearly show GPS, connection, and payment-sync status; never silently lose a state transition.
6. **Original GO JATRA experience.** Use GO JATRA’s design system: Manrope, warm ivory, forest green, restrained champagne-gold accent.

---

## Primary navigation

Use four fixed bottom-navigation destinations:

| Tab          | Purpose                                                            |
| ------------ | ------------------------------------------------------------------ |
| **Home**     | Online/offline state, map, incoming requests, quick daily metrics  |
| **Earnings** | Today/week earnings, payout, incentives, trip-level breakdown      |
| **Trips**    | Active ride, trip history, issue reporting, invoice/receipt access |
| **Profile**  | Account, vehicle, documents, support, safety, settings             |

The bottom navigation is fixed outside the scroll view. Every scrollable screen needs `96dp` bottom padding so content is never hidden behind it.

---

## 1. Captain onboarding and compliance

### Required flow

1. Mobile OTP sign-in
2. Personal profile: name, photo, date of birth, emergency contact
3. Vehicle selection: Bike / Auto / Cab / Parcel vehicle
4. Document upload: driving licence, RC, insurance, PAN/Aadhaar or other documents required by GO JATRA and local law
5. Bank account/UPI details for payouts
6. Safety and operational learning modules
7. Review state: `Submitted → Under review → Approved / Action required`

### Document UX

- Show status per document: **Verified**, **Under review**, **Expiring soon**, **Action required**.
- Show expiry date and remind at 30, 14, 7, and 1 days before expiry.
- Block going online only when a legally/operationally required document is invalid; explain the precise required action.
- Allow secure camera capture, cropping, re-uploading, and status tracking.

### Learning modules

- Regional-language content and English
- Road safety, passenger conduct, emergency process, payment flow, parcel handling
- Short quiz after each module
- Store completion server-side; show downloadable completion record

---

## 2. Home: offline and online state

### Offline home

- Large primary control: **Go online**
- Current vehicle and service types enabled
- City/service area eligibility
- Pre-flight checks: GPS enabled, connection available, documents valid, vehicle selected
- Earnings snapshot: Today / Trips / Rating
- Any blocking warning must appear before the Captain goes online.

### Online home

- Prominent green status card: **You’re online**
- Enable/disable switch with confirmation before going offline during an active request or trip
- Nearby-demand map, current location, and connection/GPS status
- Daily metric row: `Today`, `Trips`, `Rating`
- Optional demand indicator should be broad (Low / Normal / High), never promise earnings.
- Background location service indicator and battery-friendly tracking status

### Offline reasons

When a Captain goes offline, present optional quick reasons: `Taking a break`, `Vehicle issue`, `Low battery`, `End of shift`, `Other`. Do not force disclosure.

---

## 3. Incoming ride request

### Request card / bottom sheet

Show only the decision-critical information:

- Service type: Bike, Auto, Mini, Sedan, Premium, Intercity, or Parcel
- Pickup area and pickup distance
- Drop area or destination policy appropriate to the local operation
- Total trip distance and estimated duration
- Estimated payout / fare presentation, clearly labelled
- Payment type: Cash / UPI / Online
- Accessibility, luggage, parcel, or special instructions when applicable
- Countdown timer with accessible visual and audio/haptic alert

### Acceptance interaction

- Secondary action: **Decline** (outlined)
- Primary action: **Swipe to accept** (56dp high green control)
- Require the swipe thumb to reach the end; give one haptic confirmation only after successful server acknowledgement.
- After acceptance, lock duplicate taps and display `Ride accepted` before opening navigation.
- If a request expires or is taken by another Captain, close it clearly—never leave a stuck loading sheet.

### Decline handling

- Do not use aggressive or manipulative copy.
- Optional reason can improve dispatch quality: too far, vehicle issue, unsafe location, payment concern, other.
- If acceptance/completion quality affects access or incentives, publish those rules clearly in the app beforehand.

---

## 4. Active ride lifecycle

### State machine

```text
Offline
  → Online
  → Request received
  → Accepted
  → Navigate to pickup
  → Arrived
  → Trip started (OTP/PIN where required)
  → Navigate to drop
  → Payment confirmation
  → Completed
  → Earnings recorded
```

### Navigate to pickup

- Full map with pickup pin and turn-by-turn handoff to the chosen navigation app
- Customer contact through masked relay/call/chat where applicable
- `I’ve arrived` action only when near the pickup geofence
- Help/Safety action always visible

### At pickup

- Wait timer with configured grace period
- Customer no-show flow with evidence/policy confirmation
- Start-trip action protected by trip PIN/OTP if GO JATRA adopts it
- For parcel: pickup checklist, parcel photo where policy requires, and handover confirmation

### In trip

- Minimal driving-safe UI: map, destination, ETA, safety button, route issue/report button
- No dense notifications or earnings prompts while moving
- Detect prolonged GPS/network failure and show a persistent recovery state

### Completion and payment

- Present final fare breakdown before completion
- Cash: Captain confirms cash received
- Digital payment: show `Payment pending` / `Paid` from the server; never ask the Captain to assume payment success
- Receipt/trip summary, rating, issue reporting
- Auto-sync the trip result; retain a local retry queue when offline

---

## 5. Earnings, wallet, and incentives

### Earnings dashboard

- Today’s gross earnings
- Completed trips
- Online hours
- Cash collected
- Digital earnings
- Incentives/bonuses
- Adjustments and deductions, each with an explanation
- Week view and custom-date trip statement

### Payouts

- Linked bank account / UPI status
- Available balance and next settlement date
- Withdrawal or payout request flow only if supported by operations
- Payout status: Processing / Paid / Failed / Needs action
- Downloadable statement and support link for each failed payout

### Incentives

- Show exact eligibility and progress, e.g. `4 of 8 eligible rides completed`
- Define city, time-window, service-type, cancellation, and acceptance conditions visibly
- Never show an incentive as earned until server validation completes

---

## 6. Safety, support, and trust

### Safety centre

- Emergency SOS from request accepted through trip completion
- One-tap emergency call and option to share live trip status with GO JATRA emergency operations
- Trusted-contact sharing flow, subject to local policy and consent
- Incident reporting: unsafe pickup/drop, passenger misconduct, accident, vehicle issue
- Post-incident case reference and support follow-up status

### Support

- Contextual support during a trip: pickup, navigation, customer, payment, safety
- Trip-linked issue reporting after completion
- Chat/callback/ticket support with case history
- Regional language support where available

### Privacy

- Masked contact methods where feasible
- Request only location permissions needed for dispatch and active-trip tracking
- Explain background location use before requesting it
- Never expose a customer’s raw contact number by default

---

## 7. Trips and performance

### Trips tab

- Current trip pinned at the top when active
- History grouped by date
- Each row: service type, pickup/drop, fare/payout, payment state, completion/cancellation status
- Detail screen: route, timestamps, fare breakdown, support and invoice actions

### Captain quality view

- Rating and rating trend
- Completed rides
- Cancellation/acceptance metrics only with clear definitions and time windows
- Coaching suggestions framed constructively, not punitively
- Performance or account restrictions must link to policy, evidence, and appeal/support path

---

## 8. Profile and settings

Use sections:

### Account

- Edit profile
- Vehicle details
- Documents and verification
- Bank/UPI payout details
- Language

### Preferences

- Service types enabled
- Navigation-app preference
- Notification and sound settings
- Accessibility and communication preferences

### Help and legal

- Safety centre
- Help and support
- Terms, privacy, and Captain policies
- Log out

---

## 9. Notifications

| Event                 | Required behavior                                                                          |
| --------------------- | ------------------------------------------------------------------------------------------ |
| New request           | High-priority sound/haptic while online; notification must deep-link to the active request |
| Accepted request      | Confirmation + navigation-to-pickup deep link                                              |
| Customer cancellation | Clear reason/status + any applicable compensation policy                                   |
| Document expiry       | Advance reminders with direct upload action                                                |
| Payout update         | Status + statement deep link                                                               |
| Safety/support update | High-priority, case-linked notification                                                    |

Respect notification permissions and provide in-app fallbacks.

---

## 10. Reliability and backend requirements

### Core events

- Captain online/offline state
- Location heartbeat while online and active
- Ride offer created / displayed / accepted / declined / expired
- Arrival, start, completion, cancellation, payment state
- Document status changes
- Payout and incentive updates

### Rules

- Every state-changing request requires an idempotency key.
- Acceptance must be server-authoritative; first valid accepted request wins.
- Preserve pending action state locally and retry safely after connectivity returns.
- Record client timestamp, server timestamp, coarse device/network diagnostics, and location accuracy for operational disputes.
- Never calculate final payment only on-device.
- Add audit logs for document review, payouts, incentives, cancellations, and safety events.

---

## MVP delivery order

### Phase 1 — Must have

1. OTP login and Captain profile
2. Document upload/review status
3. Go online/offline with permissions and location heartbeat
4. Incoming requests with swipe-to-accept and decline
5. Pickup, trip start, active trip, completion, and payment state
6. Basic earnings/trip history
7. Trip-linked help and emergency support

### Phase 2 — High value

1. Incentives and payout self-service
2. In-app chat/callback support
3. Saved navigation preference
4. Training modules and quality dashboard
5. Parcel-specific pickup/delivery proof

### Phase 3 — Later

1. Demand insights
2. Advanced earnings forecasting
3. Referrals
4. Vehicle service/partner offers
5. Gamified achievements, only if they do not pressure unsafe driving

---

## Reference-informed considerations

Public Rapido Captain materials describe Captain onboarding with identity/vehicle documents, flexible working, wallet/bank redemption, training, platform support, and safety/support processes. GO JATRA can use those broad categories as inspiration while defining its own policies and operational details. See [Rapido’s Captain information](https://www.rapido.bike/become-a-captain), [Rapido’s Captain terms](https://www.rapido.bike/CaptainTerms), and [Rapido safety information](https://rapido.bike/Safety).

Before launch, have legal, operations, finance, and safety teams validate GO JATRA’s local compliance, service rules, payout model, insurance, document requirements, and emergency-response process.
