//
//  SwiftUIView.swift
//  AWAN
//
//  Created by munirah alsubaie on 20/02/1448 AH.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ZStack{
            Image("back")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
            VStack(spacing: 2) {

                Text("أوَانْ")
                    .font(.system(size: 70))
                    .foregroundStyle(.blue)
                    .bold()

                Image("OLD")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 420, height: 420)

                Text("Never Miss\nYour Medication")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
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
        }
    }
}

#Preview {
    SwiftUIView()
}
