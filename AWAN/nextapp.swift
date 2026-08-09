//
//  nextapp.swift
//  AWAN
//
//  Created by rataj abdullah aldebeebi on 26/02/1448 AH.
//

import SwiftUI
import UserNotifications
struct ConfirmView: View {
    @State private var showNextPage = false
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                // Background
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    Spacer()
                    
                    // Date
                    Text("22 August")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(
                            Color(red: 91/255,
                                  green: 153/255,
                                  blue: 220/255)
                        )
                        .offset(y: 50)
                    
                    Spacer()
                        .frame(height: 35)
                    
                    // Appointment Information
                    HStack(spacing: 25) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("Al Habib Hospital | Clinic 3")
                                .font(.system(size: 30))
                                .foregroundColor(.gray)
                                .offset(y: 30)
                                .offset(x: -0)
                            
                            Text("Dr. Ahmed Ali | 10 AM")
                                .font(.system(size: 30))
                                .foregroundColor(.gray)
                                .offset(y: 30)
                                .offset(x: 25)
                            
                        }
                        
                        
                    }
                    
                    Spacer()
                        .frame(height: 25)
                    
                    // Reminder
                    Text("Please bring your medications")
                        .font(.system(size: 28))
                        .foregroundColor(
                            Color(red: 50/255,
                                  green: 145/255,
                                  blue: 225/255)
                        )
                        .offset(y: 60)
                    
                    Spacer()
                        .frame(height: 65)
                    
                    // Confirm Button
                    NavigationLink(destination: myapp()) {
                        Text("Yes, I went")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(
                                Color(red: 91/255,
                                      green: 153/255,
                                      blue: 220/255)
                            )
                            .cornerRadius(19)
                        
                    }
                    
                    Spacer()
                        .frame(height: 15)
                    
                    // Remind Button
                    Button(action: {
                        UNUserNotificationCenter.current().requestAuthorization(
                            options: [.alert, .sound, .badge]
                        ) { granted, error in
                            
                            if granted {
                                scheduleReminder()
                            }
                        }
                        dismiss()
                    }) {
                        Text("Remind me in 15 minutes")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(
                                Color(red: 91/255,
                                      green: 153/255,
                                      blue: 220/255)
                            )
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(
                                Color(red: 226/255,
                                      green: 238/255,
                                      blue: 249/255)
                            )
                            .cornerRadius(19)
                        
                    }
                    
                    Spacer()
                        .frame(height: 15)
                    
                    // Skip Button
                    Button(action: {
                        
                        dismiss()
                    }) {
                        Text("Skip")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(
                                Color(red: 226/255,
                                      green: 238/255,
                                      blue: 249/255)
                            )
                            .cornerRadius(19)
                        
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 15)
            }
        }
    }
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
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error)")
            }
        }
    }
}
#Preview {
    ConfirmView()
}
