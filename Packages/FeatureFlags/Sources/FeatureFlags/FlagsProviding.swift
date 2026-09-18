import Foundation

/// The interface the app has coded against for years.
public protocol FlagsProviding {
    /// Returns `false` for any key that has not been configured.
    func isEnabled(_ key: String) -> Bool
}
