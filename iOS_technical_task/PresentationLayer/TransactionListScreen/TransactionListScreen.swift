import SwiftUI

struct TransactionListScreen: View {

    @State private var viewModel = TransactionListScreen.ViewModel()
    @State private var searchText = ""

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView("Loading transactions…")
            case .error(let message):
                ContentUnavailableView(
                    "Something went wrong",
                    systemImage: "exclamationmark.triangle",
                    description: Text(message)
                )
                .overlay(alignment: .bottom) {
                    Button("Retry") {
                        Task { await viewModel.fetch() }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 32)
                }
            case .loaded(let transactions):
                List(transactions) { transaction in
                    TransactionRow(transaction: transaction, useRelativeDates: viewModel.useRelativeDates)
                }
                .overlay {
                    if transactions.isEmpty {
                        ContentUnavailableView.search(text: searchText)
                    }
                }
            }
        }
        .navigationTitle("Transactions")
        .task {
            await viewModel.fetch()
        }
    }
}

private struct TransactionRow: View {
    let transaction: Transaction
    let useRelativeDates: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.merchantName)
                    .font(.headline)
                Text(transaction.createdAt, style: useRelativeDates ? .relative : .date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(transaction.amount.value, format: .currency(code: transaction.amount.currency))
                .fontWeight(.semibold)
                .foregroundStyle(transaction.amount.value < 0 ? .red : .primary)
        }
        .padding(.vertical, 4)
    }
}
