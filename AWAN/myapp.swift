import SwiftUI

struct myapp: View {
    @State private var isConfirmed = true

    var body: some View {
        ZStack {
            // Background
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Main content
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("My Appointments")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                        .padding(.top, 50)

                    Text("Here are your upcoming appointments")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    // ---- All your existing cards (unchanged) ----
                    // First Card - Welcome Message
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 235/255, green: 243/255, blue: 252/255))
                        .frame(height: 180)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        .overlay(
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Good morning, Fatimah")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                                Text("You have 2 upcoming appointments")
                                    .foregroundColor(.gray)
                                Spacer()
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color(red: 96/255, green: 157/255, blue: 220/255))
                                    .frame(height: 60)
                                    .overlay(
                                        HStack {
                                            Image(systemName: "calendar")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                            VStack(alignment: .leading) {
                                                Text("Next Appointment")
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                                Text("Today, 10:00 AM")
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                Text("General Check-up")
                                                    .font(.caption2)
                                                    .foregroundColor(.white)
                                            }
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.white)
                                        }
                                        .padding(.horizontal)
                                    )
                            }
                            .padding()
                        )

                    // Second Card - Appointment 1 (May 21)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 235/255, green: 243/255, blue: 252/255))
                        .frame(height: 170)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        .overlay(
                            HStack(spacing: 0) {
                                VStack(spacing: 5) {
                                    Text("May")
                                        .foregroundColor(.white)
                                    Text("21")
                                        .font(.system(size: 30, weight: .bold))
                                        .foregroundColor(.white)
                                    Text("Wed")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 90)
                                .frame(maxHeight: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(red: 96/255, green: 157/255, blue: 220/255))
                                )
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Spacer()
                                        Button {
                                            isConfirmed.toggle()
                                        } label: {
                                            Text(isConfirmed ? "Confirmed" : "Not Confirmed")
                                                .font(.system(size: 11, weight: .semibold))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .frame(minWidth: 95)
                                                .background(
                                                    isConfirmed
                                                    ? Color(red: 96/255, green: 157/255, blue: 220/255)
                                                    : Color.red
                                                )
                                                .cornerRadius(12)
                                        }
                                        Spacer()
                                    }
                                    Text("General Check-up")
                                        .bold()
                                    Text("Al Habib Hospital")
                                        .foregroundColor(.gray)
                                    HStack {
                                        Image(systemName: "clock")
                                        Text("10:00 AM")
                                        Image(systemName: "location")
                                        Text("Clinic 2")
                                    }
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.white)
                                        .frame(height: 35)
                                        .overlay(
                                            HStack {
                                                Image(systemName: "pills")
                                                    .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                                                Text("Please bring your medications")
                                                    .font(.caption)
                                                    .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                                            }
                                            .padding(.horizontal)
                                        )
                                }
                                .padding()
                            }
                        )

                    // Third Card - Appointment 2 (May 28)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 235/255, green: 243/255, blue: 252/255))
                        .frame(height: 170)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        .overlay(
                            HStack(spacing: 0) {
                                VStack(spacing: 5) {
                                    Text("May")
                                        .foregroundColor(.white)
                                    Text("28")
                                        .font(.system(size: 30, weight: .bold))
                                        .foregroundColor(.white)
                                    Text("Wed")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 90)
                                .frame(maxHeight: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(red: 96/255, green: 157/255, blue: 220/255))
                                )
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text("Upcoming")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 4)
                                            .background(Color(red: 96/255, green: 157/255, blue: 220/255))
                                            .cornerRadius(10)
                                        Spacer()
                                    }
                                    Text("Heart Disease Follow-up")
                                        .bold()
                                    Text("Al Habib Hospital")
                                        .foregroundColor(.gray)
                                    HStack {
                                        Image(systemName: "clock")
                                        Text("2:30 PM")
                                        Image(systemName: "location")
                                        Text("Clinic 6")
                                    }
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.white)
                                        .frame(height: 35)
                                        .overlay(
                                            HStack {
                                                Image(systemName: "heart.fill")
                                                    .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                                                Text("Bring your medical reports")
                                                    .font(.caption)
                                                    .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                                            }
                                            .padding(.horizontal)
                                        )
                                }
                                .padding()
                            }
                        )
                }
                .padding(.horizontal, 25)
                .padding(.bottom, 20)
            }

            // ---- NEW: Floating Plus Button ----
            // We use an overlay to place it at the bottom‑right corner
        }
        .overlay(
            NavigationLink(
                destination: SchedulePage()
                    .navigationTitle("New Appointment") // optional title
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
            .padding(.bottom, 30),
            alignment: .bottomTrailing
        )
    }
}

#Preview {
    NavigationView {   // add NavigationView for preview
        myapp()
    }
}
