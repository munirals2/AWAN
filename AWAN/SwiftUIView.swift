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
            Image("back").resizable().scaledToFill().ignoresSafeArea()
            VStack{
                
                
                Text("أوَانْ").font(.system(size: 50)).foregroundStyle(.blue).bold()
                Spacer()
                
                Image("OLD").resizable().scaledToFit().frame(width: 500, height: 500).padding(.bottom, 350).offset(y: -20)
            }
            .padding(.top, 100)
        }
    }
}

#Preview {
    SwiftUIView()
}
