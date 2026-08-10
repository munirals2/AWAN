import SwiftUI

struct MainTabView: View {
    @StateObject private var store = AppointmentStore()
    var body: some View {
        TabView {
            NavigationView {
                HomeView(store: store)
            }
            .tabItem {
                Image(systemName: "square.stack.3d.up")
                Text("List")
            }

            NavigationView {
                myapp(store: store)
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
    }
}

#Preview {
    MainTabView()
}
