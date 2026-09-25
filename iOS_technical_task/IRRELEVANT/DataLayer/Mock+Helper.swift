import Foundation

extension Date {
    /// Returns a random `Date` within the last `days` days from now.
    ///
    /// - Parameter days: The maximum number of days in the past to generate a date for.
    static func randomInPast(days: Int) -> Date {
        let secondsInDay = 86_400
        let randomSeconds = Int.random(in: 0...(days * secondsInDay))
        return Date().addingTimeInterval(TimeInterval(-randomSeconds))
    }
}
