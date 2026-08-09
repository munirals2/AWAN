//
//  nextapp.swift
//  AWAN
//
//  Created by rataj abdullah aldebeebi on 26/02/1448 AH.
//

import SwiftUI

struct ConfirmView: View {
    
    var body: some View {
        
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
                    .offset(y: 120)
                
                Spacer()
                    .frame(height: 35)
                
                // Appointment Information
                HStack(spacing: 25) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Al Habib Hospital")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                            .offset(y: 100)
                            .offset(x: 60)
                        
                        Text("Dr. Ahmed Ali")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                            .offset(y: 135)
                            .offset(x: 80)
                        
                        Text("10 AM")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                            .offset(y: 140)
                            .offset(x: 130)
                    }
                    
                    Text("Clinic 3")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                        .offset(y: 95)
                        .offset(x: -130)
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
                    .offset(y: 140)
                
                Spacer()
                    .frame(height: 65)
                
                // Confirm Button
                Button(action: {
                    print("Confirmed")
                }) {
                    Text("Yes, I went")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .background(
                            Color(red: 91/255,
                                  green: 153/255,
                                  blue: 220/255)
                        )
                        .cornerRadius(19)
                        .offset(y: 90)
                }
                
                Spacer()
                    .frame(height: 15)
                
                // Remind Button
                Button(action: {
                    print("Remind me")
                }) {
                    Text("Remind me in 15 minutes")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(
                            Color(red: 91/255,
                                  green: 153/255,
                                  blue: 220/255)
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .background(
                            Color(red: 226/255,
                                  green: 238/255,
                                  blue: 249/255)
                        )
                        .cornerRadius(19)
                        .offset(y: 90)
                }
                
                Spacer()
                    .frame(height: 15)
                
                // Skip Button
                Button(action: {
                    print("Skipped")
                }) {
                    Text("Skip")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .background(
                            Color(red: 226/255,
                                  green: 238/255,
                                  blue: 249/255)
                        )
                        .cornerRadius(19)
                        .offset(y: 90)
                }
                
                Spacer()
            }
            .padding(.horizontal, 15)
        }
    }
}

#Preview {
    ConfirmView()
}
