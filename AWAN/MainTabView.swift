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
            
            Text("List")
                .tabItem {
                    Image(systemName: "square.stack.3d.up")
                    Text("List")
                }
            
            Text("Appointments")
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

