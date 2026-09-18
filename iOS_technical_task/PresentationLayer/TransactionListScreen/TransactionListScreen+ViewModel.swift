import FeatureFlags
import Foundation
import Observation

extension TransactionListScreen {

    @MainActor
    @Observable
    final class ViewModel {
        private let networkClient: NetworkClient

        private(set) var state: LoadableState<[Transaction]> = .loading

        /// Whether transaction rows should render relative dates ("Yesterday")
        /// instead of absolute ones. Read once at launch from the injected
        /// flags provider.
        private(set) var useRelativeDates: Bool

        init(networkClient: NetworkClient, flagsProvider: FlagsProviding = LegacyFlagsClient.shared) {
            self.networkClient = networkClient
            self.useRelativeDates = flagsProvider.isEnabled("transaction_row_relative_dates")
        }

        convenience init() {
            self.init(networkClient: NetworkClient())
        }

        func fetch() async {
            state = .loading

            do {
                let response = try await networkClient.get(from: .transactions())
                state = .loaded(response.map(Transaction.init(dto:)))
            } catch {
                state = .error("Unable to load transactions.")
            }
        }

    }
}
