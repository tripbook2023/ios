import SwiftUI

@main
struct ios_tripbookApp: App {
    var body: some Scene {
        WindowGroup {
            SignUpView(viewModel: SignInViewModel(), viewType: .terms)
        }
    }
}
