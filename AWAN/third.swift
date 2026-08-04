//
//  third.swift
//  AWAN
//
//  Created by rataj abdullah aldebeebi on 21/02/1448 AH.
//

 import SwiftUI
struct swiftUIView: View {
    var body: some View {
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
                Image("grand")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 420, height: 420)
                Button(action:{}){
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


                Text("Welcome")
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

                Text("We help you easily remember your medications and appointments.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
              
                HStack(spacing: 10) {
                    Circle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 10, height: 10)
                    Circle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 10, height: 10)
                    Circle()
                        .fill(Color.blue)  
                        .frame(width: 10, height: 10)
                }
                
                
                }
                
                
            }
            .padding(.top, 60)
            .offset(y: -50)
        }
    }


#Preview {
    swiftUIView()
}
