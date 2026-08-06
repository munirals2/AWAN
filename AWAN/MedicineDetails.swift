//
//  MedicineDetails.swift
//  AWAN
//
//  Created by Tumadhir Alyahya on 23/02/1448 AH.
//

import SwiftUI

struct MedicineDetailsView: View {
    
    var body: some View {
        
        VStack {
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 750)
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 30)
        )
    }
}


#Preview {
    ZStack {
           Color.gray
           
           VStack {
               Spacer()
               
               MedicineDetailsView()
           }
       }
}
