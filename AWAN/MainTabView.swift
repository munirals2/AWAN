import SwiftUI

struct MainTabView: View {
    @StateObject private var store = AppointmentStore()
    @StateObject private var medicineStore = MedicineStore()

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
                MyMedicineView(store: medicineStore)
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
