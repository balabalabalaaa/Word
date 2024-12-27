import SwiftUI

struct ContentView: View {
    @State private var isUserLoggedIn: Bool = false
    @State private var showLoginPage: Bool = true

    var body: some View {
        if isUserLoggedIn {
            Mainpage()
        } else {
            if showLoginPage {
                LoginPage(isUserLoggedIn: $isUserLoggedIn)
            } else {
                RegistrationPage(showLoginPage: $showLoginPage)
            }
        }
    }
}

#Preview {
    ContentView()
}
