/// A generic, type-safe container for an API endpoint response.
///
/// `Endpoint` wraps a `Result` value so that the data layer can return either
/// a successfully decoded model or a typed error in a uniform way.
///
/// - Note: In this project the endpoint uses mock data. In a real implementation
///   this would encapsulate URL construction and the network call itself.
///
/// ```swift
/// let endpoint = Endpoint<[Transaction]>.transactions
/// switch endpoint.result {
/// case .success(let list): // use list
/// case .failure(let error): // handle error
/// }
/// ```
struct Endpoint<D: Decodable> {
    /// The result of the endpoint call — either a successfully decoded value or an error.
    let result: Result<D, Error>
}
