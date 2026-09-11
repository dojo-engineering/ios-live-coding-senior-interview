import Testing
@testable import iOS_technical_task

@MainActor
struct TransacionListViewModelTest {

    @Test func test_fetch() async throws {
        let viewModel = TransactionListScreen.ViewModel()

        await viewModel.fetch()

        guard case let .loaded(transactions) = viewModel.state else {
            Issue.record("Expected the view model to load transactions")
            return
        }

        #expect(transactions.count == TransactionDTO.mockList.count)
        #expect(transactions.first?.merchantName == TransactionDTO.mockList.first?.merchantName)
        #expect(transactions.first?.id == TransactionDTO.mockList.first?.id)
    }
}
