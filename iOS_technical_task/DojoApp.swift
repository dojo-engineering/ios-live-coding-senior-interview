import SwiftUI

@main
struct DojoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TransactionListScreen()
            }
        }
    }
}
