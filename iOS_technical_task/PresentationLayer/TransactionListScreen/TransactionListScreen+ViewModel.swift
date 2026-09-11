import Foundation
import Observation

extension TransactionListScreen {

    @MainActor
    @Observable
    final class ViewModel {
        private let networkClient: NetworkClient

        private(set) var state: LoadableState<[Transaction]> = .loading

        init(networkClient: NetworkClient) {
            self.networkClient = networkClient
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
