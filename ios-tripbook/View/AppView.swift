import SwiftUI
import TBUtil

@main
struct ios_tripbookApp: App {
    let tokenStorage = TokenStorage.shared
    
    var body: some Scene {
        WindowGroup {
            if let _ = tokenStorage.accessToken {
                RootView().configureFont()
            } else {
                SignupSocialView().configureFont()
            }
        }
    }
}
