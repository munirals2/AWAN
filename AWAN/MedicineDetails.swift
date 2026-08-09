//
//  MedicineDetails.swift
//  AWAN
//
//  Created by Tumadhir Alyahya on 23/02/1448 AH.
//

import SwiftUI

struct MedicineDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack(alignment: .topTrailing){
        
        VStack(spacing: 18) {
            
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
            Text("Metformin")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(
                    Color(
                        red: 96/255,
                        green: 157/255,
                        blue: 220/255
                    )
                )
            
            
            // Dose Time
            Text("Dose time: 10:00 AM")
                .font(.title3)
                .foregroundColor(.gray)
            
            
            // Dose
            Text("One pill")
                .font(.title3)
                .foregroundColor(.gray)
            
            
            // Instructions
            Text("Take after meal")
                .font(.title3)
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
                
            } label: {
                Text("Yes, I took it")
                    .font(.title3)
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
                
            } label: {
                Text("Remind me after 15 minutes")
                    .font(.title3)
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
                    .font(.title3)
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
            
            Spacer()
          
            
        }
        .padding(.top, 20)
        .frame(maxWidth: .infinity)
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
        )
            
        .clipShape(
            RoundedRectangle(cornerRadius: 30)
        )
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.gray)
                    .padding(20)
            }

            }
            
           
               
           }
    }



#Preview {
    MedicineDetailsView()
}
