//
//  MainTabView.swift
//  AWAN
//
//  Created by Tumadhir Alyahya on 22/02/1448 AH.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Image(systemName: "square.stack.3d.up")
                    Text("List")
                }

            myapp()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Appointments")
                }

            MyMedicineView()
                .tabItem {
                    Image(systemName: "pill")
                    Text("Medications")
                }
        }
    }
}

#Preview {
    MainTabView()
}
