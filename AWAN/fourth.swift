//
//  fourth.swift
//  AWAN
//
//  Created by rataj abdullah aldebeebi on 21/02/1448 AH.
//

import SwiftUI

struct HomeView: View {

    var body: some View {

        ZStack {

            // Background
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 30) {

                Spacer()
                    .frame(height: 120)

                // Medicine Card
                ZStack {
                    Image("backg")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 8)

                    VStack(spacing: 18) {

                        // المحتوى العلوي
                        HStack {

                            VStack(alignment: .leading, spacing: 6) {
                                Text("Metformin")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)

                                Text("One tablet")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            Image("medicine")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                        }
                        .padding(.horizontal, 28)
                        .padding(.top, 20)

                        // الزر
                        Button(action: {

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
                            .background(Color(red: 96/255, green: 157/255, blue: 220/255))
                            .cornerRadius(15)
                        }
                        .padding(.horizontal, 30)

                        Spacer(minLength: 25)
                    }
                }
                .frame(height: 220)

                // Appointment Card
                ZStack {

                    Image("backg")
                        .resizable()
                        .scaledToFill()
                        .frame(height:165)
                        .clipShape(RoundedRectangle(cornerRadius:28))
                        .shadow(color: .black.opacity(0.2),
                                radius:10,
                                x:0,
                                y:8)

                    HStack {

                        VStack(alignment: .leading, spacing: 8) {

                            Text("Appointments")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)

                            Text("Description")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Image("ca")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140)
                    }
                    .padding(.horizontal, 30)

                }
                .frame(height:185)

                Spacer()

                // Bottom Bar
                RoundedRectangle(cornerRadius: 35)
                    .fill(Color.white)
                    .frame(height:90)
                    .shadow(color:.black.opacity(0.15),
                            radius:10,
                            x:0,
                            y:-2)
                    .padding(.horizontal,20)

            }
            .padding(.horizontal,20)

        }

    }

}

#Preview {
    HomeView()
}
