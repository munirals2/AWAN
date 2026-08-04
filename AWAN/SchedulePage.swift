//
//  SchedulePage.swift
//  AWAN
//
//  Created by munirah alsubaie on 21/02/1448 AH.
//

import SwiftUI

struct SchedulePage: View {
    var body: some View {
        ZStack{
            Image("back").resizable().scaledToFill().ignoresSafeArea()
            
            VStack{
                HStack {
                    Image(systemName: "chevron.backward").padding(.top, 20).padding().foregroundStyle(Color(red: 0.38, green: 0.62, blue: 0.86)).bold()
                    Spacer()
                }
                
                HStack {
                    
                    Image("schedulee").resizable().scaledToFit().frame(width: 50, height: 50).padding()
                    
                    VStack(alignment: .leading){
                        Text("Add an appointment")
                            .padding(.trailing)
                            .foregroundStyle(Color(red: 0.38, green: 0.62, blue: 0.86)).bold()
                        Text("Add your appointment details to remind you at the right time.").padding(.trailing).foregroundStyle(.gray).font(.caption)
                    }
                    Spacer()
                    
                }
                
                
                
                VStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0.898, green: 0.941, blue: 0.980))
                        .frame(height: 350)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.11), radius: 8, x: 0, y: 4)
                        .overlay(
                            VStack {
                                HStack {
                                    Image(systemName: "chevron.backward").foregroundStyle(Color(red: 0.38, green: 0.62, blue: 0.86)).bold().padding()

                                    Spacer()
                                    Text("May 2026").foregroundStyle(Color(red: 0.38, green: 0.62, blue: 0.86)).bold()
                                    Spacer()
                                    Image(systemName: "chevron.forward").foregroundStyle(Color(red: 0.38, green: 0.62, blue: 0.86)).bold().padding()
                                }
                                
                                HStack {
                                    Text("Sun").frame(maxWidth: .infinity).foregroundStyle(Color(red: 0.38, green: 0.62, blue: 0.86))
                                    Text("Mon").frame(maxWidth: .infinity).foregroundStyle(Color(red: 0.38, green: 0.62, blue: 0.86))
                                    Text("Tue").frame(maxWidth: .infinity).foregroundStyle(Color(red: 0.38, green: 0.62, blue: 0.86))
                                    Text("Wed").frame(maxWidth: .infinity).foregroundStyle(Color(red: 0.38, green: 0.62, blue: 0.86))
                                    Text("Thu").frame(maxWidth: .infinity).foregroundStyle(Color(red: 0.38, green: 0.62, blue: 0.86))
                                    Text("Fri").frame(maxWidth: .infinity).foregroundStyle(Color(red: 0.38, green: 0.62, blue: 0.86))
                                    Text("Sat").frame(maxWidth: .infinity).foregroundStyle(Color(red: 0.38, green: 0.62, blue: 0.86))
                                }
                                .font(.caption)
                            }
                                .padding()
                                , alignment: .top
                            )
                }
                Spacer()
            }
            
        }
        Spacer()
        Spacer()
    }
    
}



#Preview {
    SchedulePage()
}
