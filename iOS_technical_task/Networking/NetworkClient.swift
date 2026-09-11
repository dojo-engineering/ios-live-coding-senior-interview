import Foundation

// MARK: - Errors

/// Responsible for executing network requests and returning decoded model objects.
///
/// - Note: The current implementation simulates network latency using `Task.sleep`
///   and resolves responses from mock `Endpoint` data. Replace the `get(from:)`
///   body with a real `URLSession` call when connecting to a live API.
final class NetworkClient {

    // MARK: Properties

    /// The underlying `URLSession` used to perform HTTP requests.
    private let session: URLSession

    // MARK: Init

    /// Creates a new `NetworkClient`.
    ///
    /// - Parameter session: The `URLSession` to use for requests. Defaults to `.shared`.
    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: Fetching

    /// Fetches and returns a decoded value for the given endpoint.
    ///
    /// This method introduces a simulated 500 ms delay to mimic real network
    /// latency, then resolves the endpoint's mock `Result`.
    ///
    /// - Parameter endpoint: A type-safe `Endpoint<T>` that carries the expected
    ///   response type and the mock result to return.
    /// - Returns: The successfully decoded value of type `T`.
    /// - Throws: The error wrapped in the endpoint's `.failure` case, if present.
    func get<T: Decodable>(from endpoint: Endpoint<T>) async throws -> T {
        try await Task.sleep(for: .milliseconds(500))

        switch endpoint.result {
        case .success(let success):
            return success
        case .failure(let failure):
            throw failure
        }
    }
}
