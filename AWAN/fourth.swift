//
//  fourth.swift
//  AWAN
//
//  Created by rataj abdullah aldebeebi on 21/02/1448 AH.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showMedicineDetails = false
    @State private var showConfirmView = false
    var body: some View {

        ZStack {

            // Background
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 4) {

                    Text("Tuesday, 28 July")
                        .font(.headline)
                        .foregroundColor(.gray)

                    Text("Good Morning")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(
                            Color(red: 96/255,
                                  green: 157/255,
                                  blue: 220/255)
                        )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 70)

                Spacer()
                    .frame(height: 20)
                
                // MARK: - Medicine Card
                ZStack {
                    
                    Image("backg")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .shadow(color: .black.opacity(0.2),
                                radius: 10,
                                x: 0,
                                y: 8)
                        .offset(y: -70)
                        .overlay(
                            
                            HStack {
                                Spacer()
                                
                                HStack(spacing: 6) {
                                    
                                    Text("Next Medicine")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.blue)
                                    
                                    Image(systemName: "clock.fill")
                                        .foregroundColor(.blue)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .clipShape(Capsule())
                                .offset(x: -220)
                                .offset(y: -80)
                            }
                                .padding(.top, 18)
                                .padding(.trailing, 20),
                            alignment: .topTrailing
                        )
                    
                    
                    VStack(spacing: 18) {
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Text("Metformin")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                    .offset(y: -55)
                                
                                Text("One tablet")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .offset(y: -60)
                                
                            }
                            
                            Spacer()
                            
                            Image("medicine")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 150)
                                .offset(y: -70)
                                .offset(x: 30)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 50)
                        
                        
                        Button(action: {
                            
                            showMedicineDetails = true
                            
                        }) {
                            
                            HStack(spacing: 8) {
                                
                                Text("Take Now")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                
                                Image(systemName: "bell")
                                
                            }
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
                        .offset(y: -115)
                        
                        Spacer(minLength: 25)
                    }
                }
                .frame(height: 220)
                // MARK: - Appointment Card
                ZStack {
                    
                    Image("backg")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .shadow(color: .black.opacity(0.2),
                                radius: 10,
                                x: 0,
                                y: 8)
                        .offset(y: -115)
                        .overlay(
                            HStack {
                                Spacer()
                                
                                HStack(spacing: 6) {
                                    
                                    Text("Next Appointment")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.blue)
                                    
                                 
                                    
                                    Image(systemName: "calendar")
                                        .foregroundColor(.blue)
                                    
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .clipShape(Capsule())
                                .offset(x: -190)
                                .offset(y: -120)
                            }
                                .padding(.top, 18)
                                .padding(.trailing, 20),
                            alignment: .topTrailing
                        )
                    
                    VStack(spacing: 18) {
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Text("22 August")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                    .offset(y: -95)
                                Text("Al-Habib Hospital")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .offset(y: -100)
                            }
                            
                            Spacer()
                            
                            Image("ca")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                                .offset(y: -120)
                                .offset(x:45)
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 50)
                        
                        Button(action: {
                            showConfirmView = true
                        }) {
                            
                            HStack(spacing: 8) {
                                
                                Text("Appointment Details")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Image(systemName: "calendar")
                                
                            }
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
                        .offset(y: -170)
                        
                        Spacer(minLength: 25)
                    }
                }
                .frame(height: 220)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            .sheet(isPresented: $showMedicineDetails) {
                MedicineDetailsView()
                    .presentationDetents([.height(600)])
                            .presentationDragIndicator(.hidden)
            }
            .sheet(isPresented: $showConfirmView) {
                ConfirmView()
                    .presentationDetents([.height(600)])
                    .presentationDragIndicator(.hidden)
            }

        }
    }
}

#Preview {
    HomeView()
}
