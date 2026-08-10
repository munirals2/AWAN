import SwiftUI
import UserNotifications

struct ConfirmView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: AppointmentStore
    let appointmentID: UUID
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            
            VStack(spacing: 18) {
                
                Spacer()
                
                
                // Date
                Text("22 August")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(
                        Color(
                            red: 96/255,
                            green: 157/255,
                            blue: 220/255
                        )
                    )
                
                
                // Hospital
                Text("Al Habib Hospital | Clinic 3")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                
                // Doctor
                Text("Dr. Ahmed Ali | 10 AM")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                
                // Reminder
                Text("Please bring your medications")
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
                
                
                // Yes Button
                Button {
                    store.confirmAppointment(id: appointmentID)
                    dismiss()
                } label: {
                    Text("Yes, I went")
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
                            }
                            
                            if granted {
                                scheduleReminder()
                            }
                        }
                    
                } label: {
                    Text("Remind me in 15 minutes")
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
                    dismiss()
                    
                } label: {
                    Text("Skip")
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
            .overlay(alignment: .topTrailing) {
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
}


// Notification
private func scheduleReminder() {
    
    let content = UNMutableNotificationContent()
    
    content.title = "Appointment Reminder"
    content.body = "Your appointment is coming up."
    content.sound = .default
    
    
    let trigger = UNTimeIntervalNotificationTrigger(
        timeInterval: 15 * 60,
        repeats: false
    )
    
    
    let request = UNNotificationRequest(
        identifier: "appointmentReminder",
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
    ConfirmView(
        store: AppointmentStore(),
        appointmentID: UUID()
    )
}
