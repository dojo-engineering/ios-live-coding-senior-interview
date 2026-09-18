# iOS Live Coding Exercise

Welcome! This is a collaborative live-coding exercise. We are interested in
how you think, structure your code, and communicate decisions as you go.

Please think out loud, ask questions, and explain your decisions. There is no
single correct solution.

## Prerequisites

- Xcode 26 or later
- iOS 26+ deployment target
- Do not use AI tools or agents during the exercise

## Context

The app is a working transaction list screen. You are not being asked to
build the feature — treat it as an existing, shipped part of a larger app
that other teams also depend on.

Today it reads one piece of behaviour from `LegacyFlagsClient`, an in-house
flags client the company has relied on for years: whether transaction rows
show a relative date ("Yesterday") or an absolute one. The client is
synchronous, boolean-only, and called directly from view model code.

The company is moving off it onto a new flags platform, represented here by
`NewFlagsClient` (see `Packages/FeatureFlags/Sources/FeatureFlags/NewFlagsClient.swift`).
It is not a drop-in replacement: it's asynchronous, can fail, uses its own
key namespace, and returns typed values rather than plain booleans.

`LegacyFlagsClient` and `NewFlagsClient` live in a local Swift package
(`Packages/FeatureFlags`) that the app depends on via Swift Package Manager,
rather than sitting directly inside the app target.

## Task

Migrate the app off `LegacyFlagsClient` onto `NewFlagsClient`.

You may change any part of the app to do this, including introducing new
abstractions, removing existing code, or restructuring how flags are read.
Existing behaviour and tests should keep working unless you have a good
reason to change them — call out any such decision as you make it.

You don't need to implement the new provider's SDK — it's provided. Focus on
how the app should depend on and migrate between flag sources.

## Discussion

During the exercise, be prepared to discuss:

- how you'd roll this migration out safely across a large, existing user base
- how you'd validate the new provider agrees with the old one before fully
  cutting over, and what you'd do if it disagreed
- what happens to the feature if the new provider is slow, unreachable, or
  returns something unexpected
- how this design would extend to a flag platform used by many features and
  teams, not just this one
- when you would reach for an existing open-source/third-party flagging
  solution instead of maintaining this in-house
- how you'd know it was safe to delete `LegacyFlagsClient` afterwards

There may be follow-up requirements during the conversation. The goal is not
to implement every possible production concern, but to demonstrate a
coherent solution and explain how it could evolve.

## Project structure

```text
iOS_technical_task/
├── DataLayer/
│   ├── Models/
│   │   ├── AmountDTO.swift
│   │   └── TransactionDTO.swift
│   └── TransactionsEndpoint.swift
├── Domain/
│   └── Transaction.swift               — app-facing model
├── Networking/
│   ├── Endpoint.swift
│   └── NetworkClient.swift
└── PresentationLayer/
    └── TransactionListScreen/
        ├── TransactionListScreen.swift
        └── TransactionListScreen+ViewModel.swift

Packages/FeatureFlags/                  — local Swift package, imported as `FeatureFlags`
└── Sources/FeatureFlags/
    ├── FlagsProviding.swift            — the abstraction the app already depends on
    ├── LegacyFlagsClient.swift         — the provider in use today
    └── NewFlagsClient.swift            — the provider to migrate to
```
