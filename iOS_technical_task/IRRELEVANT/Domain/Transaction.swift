import Foundation

/// App-facing transaction model.
///
/// Presentation code should depend on this model instead of transport DTOs.
struct Transaction: Identifiable, Equatable {
    let id: UUID
    let amount: Amount
    let createdAt: Date
    let merchantName: String
}

struct Amount: Equatable {
    let value: Decimal
    let currency: String
}

extension Transaction {
    init(dto: TransactionDTO) {
        self.init(
            id: dto.id,
            amount: Amount(value: dto.amount.value, currency: dto.amount.currency),
            createdAt: dto.createdAt,
            merchantName: dto.merchantName
        )
    }
}
