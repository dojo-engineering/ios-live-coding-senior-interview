import Foundation

/// A stand-in for the in-house flags client the app has used for years.
///
/// It is synchronous, keyed by ad-hoc snake_case strings, and only ever
/// returns booleans read once at startup from a local property list. Several
/// call sites depend on it directly today.
public final class LegacyFlagsClient: FlagsProviding, Sendable {

    public static let shared = LegacyFlagsClient()

    private let values: [String: Bool]

    public init(values: [String: Bool] = ["transaction_row_relative_dates": true]) {
        self.values = values
    }

    /// Returns `false` for any key that has not been configured.
    public func isEnabled(_ key: String) -> Bool {
        values[key] ?? false
    }
}
