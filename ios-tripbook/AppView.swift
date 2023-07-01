import SwiftUI
import TBUtil

@main
struct ios_tripbookApp: App {
    var body: some Scene {
        WindowGroup {
            SignupProfileInfoView(SignupViewModel()).configureFont()
        }
    }
}
