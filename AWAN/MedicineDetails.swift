import SwiftUI

struct MedicineDetailsView: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            
            VStack(spacing: 18) {
                
                Spacer()
                
                // Medicine Image
                Circle()
                    .fill(
                        Color(
                            red: 235/255,
                            green: 236/255,
                            blue: 240/255
                        )
                    )
                    .frame(width: 110, height: 110)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: 40))
                            .foregroundColor(
                                Color(
                                    red: 96/255,
                                    green: 157/255,
                                    blue: 220/255
                                )
                            )
                    )
                    .padding(.top, 10)
                
                
                // Medicine Name
                Text("Metformin")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(
                        Color(
                            red: 96/255,
                            green: 157/255,
                            blue: 220/255
                        )
                    )
                
                
                Text("Dose time: 10:00 AM")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                
                Text("One pill")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                
                Text("Take after meal")
                    .font(.title2)
                    .foregroundColor(
                        Color(
                            red: 96/255,
                            green: 157/255,
                            blue: 220/255
                        )
                    )
                
                
                Spacer()
                    .frame(height: 5)
                
                
                Button {
                    
                } label: {
                    Text("Yes, I took it")
                        .font(.title2)
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
                
                
                Button {
                    
                } label: {
                    Text("Remind me after 15 minutes")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(
                            Color(
                                red: 96/255,
                                green: 157/255,
                                blue: 220/255
                            )
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(
                            Color(
                                red: 228/255,
                                green: 238/255,
                                blue: 248/255
                            )
                        )
                        .cornerRadius(15)
                }
                .padding(.horizontal, 30)
                
                
                Button {
                    
                } label: {
                    Text("Skip this dose")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(
                            Color(
                                red: 228/255,
                                green: 238/255,
                                blue: 248/255
                            )
                        )
                        .cornerRadius(15)
                }
                .padding(.horizontal, 30)
                
                
                Spacer()
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity)
            .clipShape(
                RoundedRectangle(cornerRadius: 30)
            )
            
            // Close Button
            .overlay(alignment: .topTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40)
                }
                .padding(.top, 160)
                .padding(.trailing, 20)
                .zIndex(10)
            }
        }
    }
}


#Preview {
    MedicineDetailsView()
}
