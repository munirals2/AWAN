//
//  save.swift
//  AWAN
//
//  Created by Norah Yasser Almulhim on 26/02/1448 AH.
//

import SwiftUI
import Combine

struct Appointment: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var time: Date
    var hospitalName: String
    var visitReason: String
    var reminderOn: Bool
    var isConfirmed: Bool = false
}

final class AppointmentStore: ObservableObject {
    
    @Published var appointments: [Appointment] = []
    
    init() {
        loadAppointments()
    }
    
    func saveAppointment(_ appointment: Appointment) {
        appointments.append(appointment)
        
        if let data = try? JSONEncoder().encode(appointments) {
            UserDefaults.standard.set(data, forKey: "appointments")
        }
    }
    func confirmAppointment(id: UUID) {
        if let index = appointments.firstIndex(where: { $0.id == id }) {
            appointments[index].isConfirmed = true
            
            if let data = try? JSONEncoder().encode(appointments) {
                UserDefaults.standard.set(data, forKey: "appointments")
            }
        }
    }
    
    private func loadAppointments() {
        if let data = UserDefaults.standard.data(forKey: "appointments"),
           let saved = try? JSONDecoder().decode([Appointment].self, from: data) {
            appointments = saved
        }
    }
}

struct save: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    save()
}
