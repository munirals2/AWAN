import SwiftUI
import UserNotifications

struct MedicineDetailsView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var medicineStore: MedicineStore
    let medicineID: UUID

    private var medicine: Medicine? {
        medicineStore.medicines.first { $0.id == medicineID }
    }

    var body: some View {

        ZStack(alignment: .topTrailing) {

            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 18) {

                if medicine == nil {

                    Spacer()

                    Image(systemName: "pills")
                        .font(.system(size: 70))
                        .foregroundColor(
                            Color(
                                red: 96/255,
                                green: 157/255,
                                blue: 220/255
                            )
                        )

                    Text("No Medications")
                        .font(.system(size: 30, weight: .bold))

                    Text("You don't have any medications\nadded yet.")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                    Text("When you add a medication,\nit will appear here.")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                    Spacer()

                } else {

                    Spacer()

                    if let imageData = medicine?.imageData,
                       let uiImage = UIImage(data: imageData) {

                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())

                    } else {

                        Circle()
                            .fill(
                                Color(
                                    red: 235/255,
                                    green: 236/255,
                                    blue: 240/255
                                )
                            )
                            .frame(width: 110, height: 110)
                            .overlay(
                                Image(systemName: "pills")
                                    .font(.system(size: 40))
                                    .foregroundColor(
                                        Color(
                                            red: 96/255,
                                            green: 157/255,
                                            blue: 220/255
                                        )
                                    )
                            )
                    }

                    Text(medicine?.name ?? "")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(
                            Color(
                                red: 96/255,
                                green: 157/255,
                                blue: 220/255
                            )
                        )

                    Text(
                        "Dose time: \(medicine?.firstTime.formatted(date: .omitted, time: .shortened) ?? "")"
                    )
                    .font(.title2)
                    .foregroundColor(.gray)

                    Text("\(medicine?.doseCount ?? 0) tablet")
                        .font(.title3)
                        .foregroundColor(.gray)

                    Text(
                        medicine?.afterFood == true
                        ? "Take after meal"
                        : "Take before meal"
                    )
                    .font(.title2)
                    .foregroundColor(
                        Color(
                            red: 96/255,
                            green: 157/255,
                            blue: 220/255
                        )
                    )

                    Spacer()
                        .frame(height: 5)

                    Button {
                        if let medicine {
                            medicineStore.updateMedicineStatus(
                                id: medicine.id,
                                status: .taken
                            )
                        }

                        dismiss()

                    } label: {

                        Text("Yes, I took it")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(
                                Color(
                                    red: 96/255,
                                    green: 157/255,
                                    blue: 220/255
                                )
                            )
                            .cornerRadius(15)
                    }
                    .padding(.horizontal, 30)


                    Button {

                        UNUserNotificationCenter.current()
                            .requestAuthorization(
                                options: [.alert, .sound, .badge]
                            ) { granted, error in

                                if let error = error {
                                    print(error)
                                    return
                                }

                                if granted {
                                    scheduleMedicineReminder()
                                }
                            }

                    } label: {

                        Text("Remind me after 15 minutes")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(
                                Color(
                                    red: 96/255,
                                    green: 157/255,
                                    blue: 220/255
                                )
                            )
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(
                                Color(
                                    red: 228/255,
                                    green: 238/255,
                                    blue: 248/255
                                )
                            )
                            .cornerRadius(15)
                    }
                    .padding(.horizontal, 30)


                    Button {
                        dismiss()

                    } label: {

                        Text("Skip this dose")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(
                                Color(
                                    red: 228/255,
                                    green: 238/255,
                                    blue: 248/255
                                )
                            )
                            .cornerRadius(15)
                    }
                    .padding(.horizontal, 30)

                    Spacer()
                }
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity)


            Button {
                dismiss()

            } label: {

                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 40)
            }
            .padding(.top, 200)
            .padding(.trailing, 20)
            .zIndex(10)
        }
    }
}


// Medicine Notification
private func scheduleMedicineReminder() {

    let content = UNMutableNotificationContent()

    content.title = "Medicine Reminder"
    content.body = "Time to take your medicine."
    content.sound = .default

    let trigger = UNTimeIntervalNotificationTrigger(
        timeInterval: 15 * 60,
        repeats: false
    )

    let request = UNNotificationRequest(
        identifier: "medicineReminder",
        content: content,
        trigger: trigger
    )

    UNUserNotificationCenter.current()
        .add(request) { error in

            if let error = error {
                print("Notification error: \(error)")
            }
        }
}


#Preview {

    let store = MedicineStore()

    MedicineDetailsView(
        medicineStore: store,
        medicineID: UUID()
    )
}
