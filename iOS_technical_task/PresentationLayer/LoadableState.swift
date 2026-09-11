import Foundation

/// Represents the state of an asynchronous data-loading operation.
///
/// Use `LoadableState` to drive UI that depends on remote or async data,
/// covering all stages from the initial request through to success or failure.
///
enum LoadableState<D> {
    /// A load is currently in progress.
    case loading
    /// The load completed successfully and the associated value holds the result.
    case loaded(D)
    /// The load failed. The associated `String` contains a human-readable error message.
    case error(String)
}
