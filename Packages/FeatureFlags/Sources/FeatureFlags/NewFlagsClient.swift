import Foundation

/// The value types returned by the new remote flags provider.
///
/// Unlike the legacy client, this provider is not boolean-only: it can serve
/// experiment variants and numeric rollout configuration too.
public enum FlagValue: Equatable {
    case bool(Bool)
    case string(String)
    case number(Double)
}

/// Errors surfaced by the new provider's SDK.
public enum RemoteFlagsError: Error {
    /// The flag key is not known to the remote configuration.
    case unknownKey
    /// The simulated network call failed.
    case network
}

/// A mock implementation of the new provider, standing in for its SDK.
///
/// This mirrors the shape of a typical third-party remote-config /
/// experimentation SDK: keys are namespaced strings owned by that platform,
/// fetches are asynchronous and can fail, and values are typed rather than
/// always booleans. It exposes no app-defined protocol — like a real
/// third-party SDK, it is a concrete type you integrate against directly.
///
/// Note the deliberate differences from `LegacyFlagsClient`:
/// - keys use the platform's own kebab-case namespace, not the app's old keys
/// - every call is `async` and can `throw` (simulating network + outages)
/// - values are typed via `FlagValue`, not a plain `Bool`
public final class NewFlagsClient {

    private let remoteValues: [String: FlagValue]
    private let simulatedLatency: Duration
    private let failureRate: Double

    public init(
        remoteValues: [String: FlagValue] = ["transaction-row-relative-dates": .bool(true)],
        simulatedLatency: Duration = .milliseconds(300),
        failureRate: Double = 0.1
    ) {
        self.remoteValues = remoteValues
        self.simulatedLatency = simulatedLatency
        self.failureRate = failureRate
    }

    public func fetchFlag(key: String) async throws -> FlagValue {
        try await Task.sleep(for: simulatedLatency)

        if Double.random(in: 0...1) < failureRate {
            throw RemoteFlagsError.network
        }

        guard let value = remoteValues[key] else {
            throw RemoteFlagsError.unknownKey
        }

        return value
    }
}
