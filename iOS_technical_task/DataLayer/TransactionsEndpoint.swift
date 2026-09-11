import Foundation

/// Errors that can be thrown when working with transaction data.
enum TransactionError: Error {
    /// No transaction was found matching the requested identifier.
    case notFound
}

// MARK: - Transaction Endpoints

extension Endpoint where D == [TransactionDTO] {

    /// Returns an endpoint whose result contains the full mock list of transactions.
    ///
    /// `GET /v1/transactions`  *(mock)*
    static func transactions(search: String) -> Endpoint<[TransactionDTO]> {
        let search = search.trimmingCharacters(in: .whitespacesAndNewlines)
        let list = if search.isEmpty {
            TransactionDTO.mockList
        } else {
            TransactionDTO.mockList.filter {
                $0.merchantName.localizedCaseInsensitiveContains(search)
            }
        }

        return Endpoint(result: .success(list))
    }

    /// Returns an endpoint whose result contains a single transaction matching `id`,
    /// or a `.failure(TransactionError.notFound)` if no match exists.
    ///
    /// `GET /v1/transactions/{id}`  *(mock)*
    ///
    /// - Parameter id: The `UUID` of the transaction to look up.
    static func transaction(id: UUID) -> Endpoint<TransactionDTO> {
        guard let transaction = TransactionDTO.mockList.first(where: { $0.id == id }) else {
            return .init(result: .failure(TransactionError.notFound))
        }
        return .init(result: .success(transaction))
    }
}

// MARK: - Mock Helpers

extension TransactionDTO {

    /// Creates a single `Transaction` with randomised field values, useful for
    /// populating previews and the mock data set.
    static func mock() -> Self {
        .init(
            id: .init(),
            amount: .init(
                value: Decimal(Double.random(in: -9999...9999)),
                currency: "GBP"
            ),
            createdAt: Date.randomInPast(days: 30),
            merchantName: ["Dojo", "Acme", "Foo Bar"].randomElement() ?? "Dojo"
        )
    }

    /// A pre-generated list of 100 mock transactions, shared across the app
    /// so that list and detail screens reference the same data.
    static let mockList: [Self] = (0..<100).map { _ in .mock() }
}
