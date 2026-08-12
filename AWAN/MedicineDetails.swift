import SwiftUI
import UserNotifications

struct MedicineDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var medicineStore: MedicineStore
    let medicine: Medicine
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            
            VStack(spacing: 18) {
                
                Spacer()
                
                
                // Medicine Image
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
                        Image(systemName: "photo")
                            .font(.system(size: 40))
                            .foregroundColor(
                                Color(
                                    red: 96/255,
                                    green: 157/255,
                                    blue: 220/255
                                )
                            )
                    )
                    .padding(.top, 10)
                
                
                
                // Medicine Name
                Text(medicine.name)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(
                        Color(
                            red: 96/255,
                            green: 157/255,
                            blue: 220/255
                        )
                    )
                
                
                
                Text("Dose time: \(medicine.firstTime.formatted(date: .omitted, time: .shortened))")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                
                
                Text("\(medicine.doseCount) pill")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                
                
                Text(medicine.afterFood ? "Take after meal" : "Take before meal")
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
                
                
                
                // Taken Button
                Button {
                    medicineStore.updateMedicineStatus(
                        id: medicine.id,
                        status: .taken
                    )
                    
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
                
                
                
                // Reminder Button
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
                
                
                
                // Skip Button
                Button {
                    
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
            .padding(.top, 20)
            .frame(maxWidth: .infinity)
            
            
            
            // Close Button
            Button {
                dismiss()
                
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 40)
            }
            .padding(.top, 160)
            .padding(.trailing, 20)
            .zIndex(10)
        }
    }
}



// Medicine Notification
private func scheduleMedicineReminder() {
    
    let content = UNMutableNotificationContent()
    
    content.title = "Medicine Reminder"
    content.body = "Time to take your Metformin."
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
    MedicineDetailsView(
        medicineStore: MedicineStore(),
        medicine: Medicine(
            name: "Metformin",
            doseCount: 1,
            firstTime: Date(),
            afterFood: true
        )
    )
}
