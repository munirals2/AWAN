import SwiftUI

struct MyMedicineView: View {
    @ObservedObject var store: MedicineStore

    private let blue = Color(red: 96/255, green: 157/255, blue: 220/255)
    private let cardBg = Color(red: 228/255, green: 238/255, blue: 248/255)

    // Medicines sorted by their first dose time, earliest first
    private var sortedMedicines: [Medicine] {
        store.medicines.sorted { $0.firstTime < $1.firstTime }
    }

    private var takenCount: Int {
        store.medicines.filter { $0.status == .taken }.count
    }

    private var totalCount: Int {
        max(store.medicines.count, 1) // avoid divide-by-zero in ProgressView
    }

    // The earliest still-pending medicine is treated as "Now"
    private var nextPendingID: UUID? {
        sortedMedicines.first(where: { $0.status == .pending })?.id
    }

    private func badge(for medicine: Medicine) -> (text: String, color: Color) {
        switch medicine.status {
        case .taken:
            return ("Taken", Color(red: 120/255, green: 200/255, blue: 130/255))
        case .skipped:
            return ("Skipped", Color.gray)
        case .pending:
            if medicine.id == nextPendingID {
                return ("Now", blue)
            }
            // within the next 3 hours counts as "Soon", otherwise "Later"
            let hoursAway = medicine.firstTime.timeIntervalSinceNow / 3600
            if hoursAway >= 0 && hoursAway <= 3 {
                return ("Soon", Color(red: 255/255, green: 180/255, blue: 90/255))
            }
            return ("Later", Color.gray)
        }
    }

    private func timeString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }

    var body: some View {
        ZStack {
            // Background
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // Header Card
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(cardBg)
                        .frame(height: 140)

                    HStack {
                        Spacer()

                        VStack(alignment: .leading, spacing: 6) {
                            Text("My Medicines")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(blue)

                            Text("\(takenCount) of \(store.medicines.count) taken today")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)

                            ProgressView(value: Double(takenCount), total: Double(totalCount))
                                .progressViewStyle(LinearProgressViewStyle())
                                .frame(height: 6)
                                .background(Color.blue.opacity(0.15))
                                .cornerRadius(3)
                        }

                        Spacer()

                        Image("CALENDER")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 100)
                    }
                    .padding(20)
                }
                .padding(.horizontal, 16)
                .padding(.top, 97)

                // Empty state
                if store.medicines.isEmpty {
                    Spacer()
                    VStack(spacing: 10) {
                        Image(systemName: "pills")
                            .font(.system(size: 40))
                            .foregroundColor(.gray.opacity(0.5))
                        Text("No medicines yet")
                            .foregroundColor(.gray)
                        Text("Tap the + button to add your first medicine")
                            .font(.caption)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    Spacer()
                } else {
                    // Timeline + Cards
                    ScrollView {
                        HStack(alignment: .top, spacing: 0) {

                            // Timeline column
                            ZStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 2)
                                    .padding(.vertical, 25)

                                VStack(spacing: 0) {
                                    ForEach(sortedMedicines) { medicine in
                                        timelineDot(for: medicine)
                                            .frame(height: 96)
                                    }
                                }
                            }
                            .frame(width: 35)
                            .padding(.leading, 20)

                            // Cards column
                            VStack(spacing: 16) {
                                ForEach(sortedMedicines) { medicine in
                                    medicineCard(medicine)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 25)
                        .padding(.bottom, 140)
                    }
                }
            }
        }
        // Plus button raised higher
        .overlay(
            NavigationLink(
                destination: AddMed(store: store)
                    .navigationTitle("New Medicine")
                    .navigationBarTitleDisplayMode(.inline)
            ) {
                Image(systemName: "plus")
                    .font(.system(size: 30, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 65, height: 65)
                    .background(blue)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .padding(.trailing, 30)
            .padding(.bottom, 90),
            alignment: .bottomTrailing
        )
    }

    // ──────────── Timeline dot ────────────

    @ViewBuilder
    private func timelineDot(for medicine: Medicine) -> some View {
        switch medicine.status {
        case .taken:
            Circle()
                .fill(Color(red: 120/255, green: 200/255, blue: 130/255))
                .frame(width: 35, height: 35)
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                )
        case .pending where medicine.id == nextPendingID:
            Circle()
                .fill(blue)
                .frame(width: 35, height: 35)
                .overlay(
                    Circle().fill(Color.white).frame(width: 10, height: 10)
                )
        default:
            Circle()
                .fill(Color.white)
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .frame(width: 35, height: 35)
        }
    }

    // ──────────── Medicine card ────────────

    private func medicineCard(_ medicine: Medicine) -> some View {
        let badgeInfo = badge(for: medicine)

        return HStack {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 5) {
                    Image(systemName: "clock")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Text(timeString(medicine.firstTime))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Text("\(medicine.name) | \(medicine.doseCount) pill\(medicine.doseCount > 1 ? "s" : "")")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(blue)
            }
            Spacer()
            Text(badgeInfo.text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 6)
                .background(Capsule().fill(badgeInfo.color))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(cardBg))
        .onTapGesture {
            // Toggle taken/pending for now — tapping a card marks it taken
            store.updateMedicineStatus(
                id: medicine.id,
                status: medicine.status == .taken ? .pending : .taken
            )
        }
    }
}

struct CustomProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 190/255, green: 215/255, blue: 240/255))

                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 120/255, green: 175/255, blue: 225/255))
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0))
            }
        }
    }
}


#Preview {
    MedicinePreviewWrapper()
}

struct MedicinePreviewWrapper: View {
    @State private var selectedTab = 2
    @StateObject private var store = AppointmentStore()
    @StateObject private var medicineStore = MedicineStore()

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView(store: store)
            }
            .tabItem {
                Image(systemName: "square.stack.3d.up")
                Text("List")
            }
            .tag(0)

            NavigationView {
                myapp(store: store)
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Appointments")
            }
            .tag(1)

            NavigationView {
                MyMedicineView(store: medicineStore)
            }
            .tabItem {
                Image(systemName: "pill")
                Text("Medications")
            }
            .tag(2)
        }
        .accentColor(blueColor)
    }

    private var blueColor: Color {
        Color(red: 96/255, green: 157/255, blue: 220/255)
    }
}
