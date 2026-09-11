# iOS Live Coding Exercise

Welcome! This is a collaborative live-coding exercise. We are interested in
how you think, structure your code, and communicate decisions as you go.

Please think out loud, ask questions, and explain your decisions. There is no
single correct solution.

## Prerequisites

- Xcode 26 or later
- iOS 26+ deployment target
- No third-party dependencies
- Do not use AI tools or agents during the exercise

## Context

The application displays a list of financial transactions. The project
contains a SwiftUI shell, transaction models, and a mocked network client.
Some of the application is intentionally incomplete.

Treat this as the starting point for a feature that will grow into a
production application. Make reasonable assumptions, call out ambiguity, and
prioritise the work you believe creates the most value.

## Task

Build out the transaction experience. It should:

- display transactions loaded from the supplied data source
- support searching by merchant
- provide an understandable experience while data is loading or unavailable

The feature is expected to handle a growing data set and unreliable network
connectivity. Extend the behaviour where you think it is important for a
production-quality implementation. You may refactor the existing code.

Use SwiftUI and Swift Concurrency. Do not add third-party dependencies.

## Discussion

During the exercise, be prepared to discuss:

- how the design would evolve as the data set grows
- how network failures and cached data should affect the user experience
- how concurrent requests, cancellation, and refreshes are handled
- how the code could be tested
- which decisions you would revisit with more product or API information

There may be follow-up requirements during the conversation. The goal is not
to implement every possible production concern, but to demonstrate a coherent
solution and explain how it could evolve.

## Project structure

```text
iOS_technical_task/
├── DataLayer/
│   ├── Models/
│   │   ├── AmountDTO.swift
│   │   └── TransactionDTO.swift
│   ├── TransactionsEndpoint.swift
│   └── TransactionsRepository.swift   — available extension point
├── Domain/
│   └── Transaction.swift               — app-facing model
├── Networking/
│   ├── Endpoint.swift
│   └── NetworkClient.swift
└── PresentationLayer/
    └── TransactionListScreen/
        ├── TransactionListScreen.swift
        └── TransactionListScreen+ViewModel.swift
```
