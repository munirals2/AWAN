import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image(systemName: "square.stack.3d.up")
                Text("List")
            }

            NavigationView {
                myapp()
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Appointments")
            }

            NavigationView {
                MyMedicineView()
            }
            .tabItem {
                Image(systemName: "pill")
                Text("Medications")
            }
        }
        .navigationViewStyle(.stack) // optional but recommended for iPad
    }
}

#Preview {
    MainTabView()
}
