import Foundation

/// A monetary amount expressed as a decimal value and an ISO 4217 currency code.
struct AmountDTO: Decodable {
    /// The numeric value of the amount (e.g. `9.99`).
    let value: Decimal
    /// The ISO 4217 currency code (e.g. `"GBP"`, `"USD"`).
    let currency: String
}
