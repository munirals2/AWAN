import SwiftUI

struct myapp: View {
    @State private var isConfirmed = true
    // Create a store instance for this view (or use a shared one)
    @ObservedObject var store: AppointmentStore
    @State private var editingAppointment: Appointment?
    @State private var showDeleteAlert = false
    @State private var appointmentToDelete: Appointment?

    var body: some View {
        ZStack {
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("My Appointments")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(Color(red: 96/255, green: 157/255, blue: 220/255))
                        .padding(.top, 100)

                    Text("Here are your upcoming appointments")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    // First Card - Welcome Message
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 235/255, green: 243/255, blue: 252/255))
                        .frame(height: 180)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        .overlay(
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Good morning,")
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
                    
                    // Third Card - Appointment 2 (May 28)
                                        ForEach(store.appointments) { appointment in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 235/255, green: 243/255, blue: 252/255))
                            .frame(height: 170)
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                            .overlay(
                                HStack(spacing: 0) {
                                    
                                    VStack(spacing: 5) {
                                        Text(appointment.date, format: .dateTime.month(.abbreviated))
                                            .foregroundColor(.white)
                                        
                                        Text(appointment.date, format: .dateTime.day())
                                            .font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.white)
                                        
                                        Text(appointment.date, format: .dateTime.weekday(.abbreviated))
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

                                                Menu {
                                                Button {
                                                                       editingAppointment = appointment
                                                                   } label: {
                                                                       Label("Edit", systemImage: "pencil")
                                                                   }

                                                                   Button(role: .destructive) {
                                                                       appointmentToDelete = appointment
                                                                       showDeleteAlert = true
                                                                   } label: {
                                                                       Label("Delete", systemImage: "trash")
                                                                   }

                                                               } label: {
                                                                   Image(systemName: "ellipsis")
                                                                       .font(.title3)
                                                                       .foregroundColor(.gray)
                                                                       .padding(5)
                                                               }
                                                           }
                                        
                                        Text(appointment.isConfirmed ? "Confirmed" : "Upcoming")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 4)
                                            .background(
                                                Color(red: 96/255, green: 157/255, blue: 220/255)
                                            )
                                            .cornerRadius(10)
                                        
                                        Text(appointment.visitReason)
                                            .bold()
                                        
                                        Text(appointment.hospitalName)
                                            .foregroundColor(.gray)
                                        
                                        HStack {
                                            Image(systemName: "clock")
                                            Text(appointment.time, style: .time)
                                            
                                            Image(systemName: "location")
                                            Text("Clinic")
                                        }
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(.white)
                                            .frame(height: 35)
                                            .overlay(
                                                HStack {
                                                    Image(systemName: "heart.fill")
                                                        .foregroundColor(
                                                            Color(red: 96/255, green: 157/255, blue: 220/255)
                                                        )
                                                    
                                                    Text("Appointment reminder")
                                                        .font(.caption)
                                                        .foregroundColor(
                                                            Color(red: 96/255, green: 157/255, blue: 220/255)
                                                        )
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "chevron.right")
                                                        .foregroundColor(
                                                            Color(red: 96/255, green: 157/255, blue: 220/255)
                                                        )
                                                }
                                                .padding(.horizontal)
                                            )
                                    }
                                    .padding()
                                }
                            )
                    }
                }
                .padding(.horizontal, 25)
                .padding(.bottom, 20)
            }
        }
        .overlay(
            NavigationLink(
                destination: SchedulePage(store: store)  //  Pass the store
                    .navigationTitle("")
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
            .padding(.bottom, 110),
            alignment: .bottomTrailing
        )
        .alert("Delete Appointment?", isPresented: $showDeleteAlert) {
            
            Button("Delete", role: .destructive) {
                if let appointment = appointmentToDelete {
                    store.deleteAppointment(id: appointment.id)
                    appointmentToDelete = nil
                }
            }
            
            Button("Cancel", role: .cancel) {
                appointmentToDelete = nil
            }
            
        } message: {
            Text("Are you sure you want to delete this appointment?")
        }
        .sheet(item: $editingAppointment) { appointment in
            SchedulePage(
                store: store,
                appointmentToEdit: appointment
            )
        }
    }
}

#Preview {
    PreviewWrapper()
}

struct PreviewWrapper: View {
    @State private var selectedTab = 1
    @StateObject private var store = AppointmentStore()
    @StateObject private var medicineStore = MedicineStore()

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView(store: store)
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "square.stack.3d.up")
                Text("List")
            }
            .tag(0)

            NavigationView {
                myapp(store: store)
                    .navigationTitle("Appointments")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Appointments")
            }
            .tag(1)

            NavigationView {
                MyMedicineView(store: medicineStore)
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
