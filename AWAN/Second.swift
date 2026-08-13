//
//  Second.swift
//  AWAN
//
//  Created by Norah Yasser Almulhim on 21/02/1448 AH.
//

import SwiftUI

struct Second: View {
    var body: some View {
        NavigationStack {
            ZStack{
                Image("back")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack(spacing: 1) {
                    
                    Text("أوَانْ")
                        .font(.system(size: 70))
                        .foregroundStyle(
                            Color(
                                red: 96/255,
                                green: 157/255,
                                blue: 220/255
                            )
                        )
                        .bold()
                    
                    Image("OLD2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    
                    NavigationLink(destination: swiftUIView()){
                        Text("Next")
                            .font(.title)
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
                    .padding(.top, 20)
                    
                    
                    Text("Organize Your\nMedical Appointments")
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                        .foregroundStyle(
                            Color(
                                red: 96/255,
                                green: 157/255,
                                blue: 220/255
                                
                            )
                        )
                        .multilineTextAlignment(.center)
                    
                    Text("Keep all your medical appointments in one place for easy tracking.")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    HStack(spacing: 10){
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 10, height: 10)
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 10, height: 10)
                    }
                    
                }
                
                .padding(.top, 60)
                .offset(y: -30)
                
                
                VStack{
                    HStack{
                        Spacer()
                        
                        NavigationLink(destination: swiftUIView()){
                            Text("Skip")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 30)
                    
                    Spacer()
                    
                }
            }
            
        }
        
    }
    
}
#Preview {
    Second()
}
