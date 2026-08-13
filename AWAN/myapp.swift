import SwiftUI

struct myapp: View {
    
    @State private var isConfirmed = true
    
    @ObservedObject var store: AppointmentStore
    
    @State private var editingAppointment: Appointment?
    @State private var showDeleteAlert = false
    @State private var appointmentToDelete: Appointment?
    private var upcomingAppointments: [Appointment] {
        store.appointments.filter {
            Calendar.current.startOfDay(for: $0.date) >= Calendar.current.startOfDay(for: Date())
        }
    }
    private var nextAppointment: Appointment? {
        upcomingAppointments.sorted {
            if Calendar.current.isDate($0.date, inSameDayAs: $1.date) {
                return $0.time < $1.time
            }
            return $0.date < $1.date
        }.first
    }
    private var appointmentCountText: String {
        let count = upcomingAppointments.count

        if count == 0 {
            return "You have no upcoming appointments"
        } else if count == 1 {
            return "You have 1 upcoming appointment"
        } else {
            return "You have \(count) upcoming appointments"
        }
    }
    
    var body: some View {
        
        ZStack {
            
            // Background
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 15) {

                    //Title
                    
                    Text("My Appointments")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(
                            Color(
                                red: 96/255,
                                green: 157/255,
                                blue: 220/255
                            )
                        )
                        .padding(.top, 100)
                    
                    Text("Here are your upcoming appointments")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    

                        //Welcome Card
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            Color(
                                red: 235/255,
                                green: 243/255,
                                blue: 252/255
                            )
                        )
                        .frame(height: 180)
                        .shadow(
                            color: .black.opacity(0.1),
                            radius: 8,
                            x: 0,
                            y: 4
                        )
                        .overlay(
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text("Welcome")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(
                                        Color(
                                            red: 96/255,
                                            green: 157/255,
                                            blue: 220/255
                                        )
                                    )
                                
                                Text(appointmentCountText)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(
                                        Color(
                                            red: 96/255,
                                            green: 157/255,
                                            blue: 220/255
                                        )
                                    )
                                    .frame(height: 60)
                                    .overlay(
                                        HStack {
                                            
                                            Image(systemName: "calendar")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                            
                                            VStack(alignment: .leading, spacing: 1) {

                                                if nextAppointment != nil {
                                                    Text("Next Appointment")
                                                        .font(.system(size: 11))
                                                        .foregroundColor(.white)
                                                }

                                                if let appointment = nextAppointment {

                                                    Text(
                                                        appointment.date,
                                                        format: .dateTime.weekday(.abbreviated)
                                                    )
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(.white)

                                                    Text(
                                                        appointment.time,
                                                        style: .time
                                                    )
                                                    .font(.system(size: 14, weight: .bold))
                                                    .foregroundColor(.white)

                                                    
                                                }
                                            }
                                            
                                            Spacer()
                                            
                                            
                                        }
                                        .padding(.horizontal)
                                    )
                            }
                            .padding()
                        )
                    
//Appointments
                    
                    if store.appointments.isEmpty {
                        
                        // No appointments
                        VStack(spacing: 12) {
                            
                            Image(systemName: "calendar.badge.exclamationmark")
                                .font(.system(size: 45))
                                .foregroundColor(.gray.opacity(0.5))
                            
                            Text("No appointments yet")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            
                            Text("Tap the + button to add your first appointment")
                                .font(.subheadline)
                                .foregroundColor(.gray.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 50)
                        
                    } else {
                        
                        // Show appointments
                        ForEach(store.appointments) { appointment in
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    Color(
                                        red: 235/255,
                                        green: 243/255,
                                        blue: 252/255
                                    )
                                )
                                .frame(height: 170)
                                .shadow(
                                    color: .black.opacity(0.1),
                                    radius: 8,
                                    x: 0,
                                    y: 4
                                )
                                .overlay(
                                    HStack(spacing: 0) {
                                        
                                        // MARK: Date
                                        
                                        VStack(spacing: 5) {
                                            
                                            Text(
                                                appointment.date,
                                                format: .dateTime.month(.abbreviated)
                                            )
                                            .foregroundColor(.white)
                                            
                                            Text(
                                                appointment.date,
                                                format: .dateTime.day()
                                            )
                                            .font(
                                                .system(
                                                    size: 30,
                                                    weight: .bold
                                                )
                                            )
                                            .foregroundColor(.white)
                                            
                                            Text(
                                                appointment.date,
                                                format: .dateTime.weekday(.abbreviated)
                                            )
                                            .foregroundColor(.white)
                                        }
                                        .frame(width: 90)
                                        .frame(maxHeight: .infinity)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(
                                                    Color(
                                                        red: 96/255,
                                                        green: 157/255,
                                                        blue: 220/255
                                                    )
                                                )
                                        )
                                        
                                        
                                        // MARK: Appointment Details
                                        
                                        VStack(
                                            alignment: .leading,
                                            spacing: 8
                                        ) {
                                            
                                            // Edit / Delete
                                            HStack {
                                                
                                                Spacer()
                                                
                                                Menu {
                                                    
                                                    // Edit
                                                    Button {
                                                        editingAppointment = appointment
                                                    } label: {
                                                        Label(
                                                            "Edit",
                                                            systemImage: "pencil"
                                                        )
                                                    }
                                                    
                                                    // Delete
                                                    Button(
                                                        role: .destructive
                                                    ) {
                                                        appointmentToDelete = appointment
                                                        showDeleteAlert = true
                                                    } label: {
                                                        Label(
                                                            "Delete",
                                                            systemImage: "trash"
                                                        )
                                                    }
                                                    
                                                } label: {
                                                    Image(
                                                        systemName: "ellipsis"
                                                    )
                                                    .font(.title3)
                                                    .foregroundColor(.gray)
                                                    .padding(5)
                                                }
                                            }
                                            
                                            
                                            // Status
                                            Text(
                                                appointment.isConfirmed
                                                ? "Confirmed"
                                                : "Upcoming"
                                            )
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 4)
                                            .background(
                                                Color(
                                                    red: 96/255,
                                                    green: 157/255,
                                                    blue: 220/255
                                                )
                                            )
                                            .cornerRadius(10)
                                            
                                            
                                            // Visit reason
                                            Text(appointment.visitReason)
                                                .bold()
                                            
                                            
                                            // Hospital
                                            Text(appointment.hospitalName)
                                                .foregroundColor(.gray)
                                            
                                            
                                            // Time / Clinic
                                            HStack {
                                                
                                                Image(systemName: "clock")
                                                
                                                Text(
                                                    appointment.time,
                                                    style: .time
                                                )
                                                
                                              
                                            }
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            
                                        }
                                        .padding()
                                    }
                                )
                        }
                    }
                }
                .padding(.horizontal, 25)
                .padding(.bottom, 140)
            }
            

            //Add Appointment Button
            
            NavigationLink(
                destination:
                    SchedulePage(store: store)
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
            ) {
                Image(systemName: "plus")
                    .font(
                        .system(
                            size: 30,
                            weight: .medium
                        )
                    )
                    .foregroundColor(.white)
                    .frame(width: 65, height: 65)
                    .background(
                        Color(
                            red: 96/255,
                            green: 157/255,
                            blue: 220/255
                        )
                    )
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .padding(.trailing, 30)
            .padding(.bottom, 90)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottomTrailing
            )
        }
        

        //Delete Alert
        
        .alert(
            "Delete Appointment?",
            isPresented: $showDeleteAlert
        ) {
            
            Button(
                "Delete",
                role: .destructive
            ) {
                
                if let appointment = appointmentToDelete {
                    store.deleteAppointment(
                        id: appointment.id
                    )
                    
                    appointmentToDelete = nil
                }
            }
            
            Button(
                "Cancel",
                role: .cancel
            ) {
                appointmentToDelete = nil
            }
            
        } message: {
            Text(
                "Are you sure you want to delete this appointment?"
            )
        }
        
        
//Edit Appointment
        
        .sheet(item: $editingAppointment) { appointment in
            
            SchedulePage(
                store: store,
                appointmentToEdit: appointment
            )
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}


//Preview

#Preview {
    PreviewWrapper()
}


struct PreviewWrapper: View {
    
    @State private var selectedTab = 1
    
    @StateObject private var store = AppointmentStore()
    
    @StateObject private var medicineStore = MedicineStore()
    
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            // MARK: List
            
            NavigationView {
                HomeView(store: store,
                         medicineStore: medicineStore)
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "square.stack.3d.up")
                Text("List")
            }
            .tag(0)
            
            
            // MARK: Appointments
            
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
            
            
            // MARK: Medications
            
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
        .accentColor(
            Color(
                red: 96/255,
                green: 157/255,
                blue: 220/255
            )
        )
    }
}
