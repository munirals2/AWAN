//
//  SwiftUIView.swift
//  AWAN
//
//  Created by munirah alsubaie on 20/02/1448 AH.
//

import SwiftUI

struct SwiftUIView: View {
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
                    Image("OLD")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 420, height: 420)
                    NavigationLink(destination: Second()) {
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
                    
                    
                    Text("Never Miss\nYour Medication")
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
                    
                    Text("We'll remind you at the right time so you never forget your medicine.")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    HStack(spacing: 10){
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 10, height: 10)
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 10, height: 10)
                    }
                    
                }
                .padding(.top, 60)
                .offset(y: -20)
                VStack{
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            
                        }){
                            Text("Skip")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 50)
                    
                    Spacer()
                    
                }
                
                
                
                
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        
    }
}
#Preview {
    SwiftUIView()
}
