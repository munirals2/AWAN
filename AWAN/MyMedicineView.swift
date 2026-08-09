import SwiftUI

struct MyMedicineView: View {
    var body: some View {
        ZStack {
            // Background
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Header Card
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(red: 228/255, green: 238/255, blue: 248/255))
                    .frame(width: 376, height: 140)
                
                HStack {
                    Spacer() // ← pushes everything to the right
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("My Medicines")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                            .offset(x:25)
                        
                        Text("1 of 4 taken today")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .offset(x:25)
                        
                        ProgressView(value: 1, total: 4)
                            .progressViewStyle(LinearProgressViewStyle())
                            .frame(height: 6)
                            .background(Color.blue.opacity(0.15))
                            .cornerRadius(3)
                            .offset(x:25, y: 5)
                    }
                    
                    Spacer()
                    
                    Image("CALENDER")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 100)
                }
                .padding(10)
            }
            .padding(.top, -350)

            // TIMELINE
            ZStack {
                // Line
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 2, height: 467)
                
                // Circles
                VStack(spacing: 95) {
                    Circle()
                        .fill(Color(red: 120/255, green: 200/255, blue: 130/255))
                        .frame(width: 35, height: 35)
                        .overlay(
                            Image(systemName: "checkmark")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        )
                    
                    Circle()
                        .fill(Color(red: 96/255, green: 157/255, blue: 220/255))
                        .frame(width: 35, height: 35)
                        .overlay(
                            Circle()
                                .fill(Color.white)
                                .frame(width: 10, height: 10)
                        )
                    
                    Circle()
                        .fill(Color.white)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        .frame(width: 35, height: 35)
                    
                    Circle()
                        .fill(Color.white)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        .frame(width: 35, height: 35)
                }
            }
            .frame(width: 35, height: 450)
            .offset(x: -170, y: 25)

            // Medicine Cards
            // 8:00 AM
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 5) {
                            Image(systemName: "clock")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            Text("8:00 AM")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Text("Metformin | 1 pill")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                    }
                    Spacer()
                    Text("Taken")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(Color(red: 120/255, green: 200/255, blue: 130/255)))
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(red: 228/255, green: 238/255, blue: 248/255)))
                .padding(.leading, 70)
                .padding(.trailing, 20)
            }
            .offset(y: -160)

            // 10:00 AM
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 5) {
                            Image(systemName: "clock")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            Text("10:00 AM")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Text("Lisinopril | 1 pill")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                    }
                    Spacer()
                    Text("Now")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(Color(red: 96/255, green: 157/255, blue: 220/255)))
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(red: 228/255, green: 238/255, blue: 248/255)))
                .padding(.leading, 70)
                .padding(.trailing, 20)
            }
            .offset(y: -40)

            // 6:00 PM
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 5) {
                            Image(systemName: "clock")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            Text("6:00 PM")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Text("Vitamin D | 2 pill")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                    }
                    Spacer()
                    Text("Soon")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(Color(red: 255/255, green: 180/255, blue: 90/255)))
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(red: 228/255, green: 238/255, blue: 248/255)))
                .padding(.leading, 70)
                .padding(.trailing, 20)
            }
            .offset(y: 80)

            // 9:00 PM
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 5) {
                            Image(systemName: "clock")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            Text("9:00 PM")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Text("Atorvastatin | 1 pill")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                    }
                    Spacer()
                    Text("Later")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(Color.gray))
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(red: 228/255, green: 238/255, blue: 248/255)))
                .padding(.leading, 70)
                .padding(.trailing, 20)
            }
            .offset(y: 200)
        }
        .navigationTitle("Medications")
        .navigationBarTitleDisplayMode(.inline)
        // Plus button raised higher
        .overlay(
            NavigationLink(
                destination: AddMed()
                    .navigationTitle("New Medicine")
                    .navigationBarTitleDisplayMode(.inline)
            ) {
                Image(systemName: "plus")
                    .font(.system(size: 30, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 65, height: 65)
                    .background(Color(red: 96/255, green: 157/255, blue: 220/255))
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 110), // raised higher
            alignment: .bottomTrailing
        )
    }
}

struct CustomProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 190/255, green: 215/255, blue: 240/255))
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 120/255, green: 175/255, blue: 225/255))
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0))
            }
        }
    }
}


#Preview {
    MedicinePreviewWrapper()
}

struct MedicinePreviewWrapper: View {
    @State private var selectedTab = 2 // Medications tab selected
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView()
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "square.stack.3d.up")
                Text("List")
            }
            .tag(0)

            NavigationView {
                myapp()
                    .navigationTitle("Appointments")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Appointments")
            }
            .tag(1)

            NavigationView {
                MyMedicineView()
                    .navigationTitle("Medications")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "pill")
                Text("Medications")
            }
            .tag(2)
        }
        .accentColor(Color(red: 96/255, green: 157/255, blue: 220/255))
    }
}
