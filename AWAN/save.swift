//
//  save.swift
//  AWAN
//
//  Created by Norah Yasser Almulhim on 26/02/1448 AH.
//

import SwiftUI
import Combine

//Appointment (existing)
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
        saveToDisk()
    }
    func updateAppointment(_ appointment: Appointment) {
        if let index = appointments.firstIndex(where: { $0.id == appointment.id }) {
            appointments[index] = appointment
            saveToDisk()
        }
    }

    func deleteAppointment(id: UUID) {
        appointments.removeAll { $0.id == id }
        saveToDisk()
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
    
    private func saveToDisk() {
        if let data = try? JSONEncoder().encode(appointments) {
            UserDefaults.standard.set(data, forKey: "appointments")
        }
    }
}

//Medicine Status Enum
enum MedicineStatus: String, Codable {
    case pending   // not taken yet
    case taken     // user took it
    case skipped   // user skipped
}

//Medicine with Status
struct Medicine: Identifiable, Codable {
    var id = UUID()
    var name: String
    var doseCount: Int
    var firstTime: Date
    var everyHours: Int
    var afterFood: Bool
    var imageData: Data?
    var status: MedicineStatus = .pending  // ✅ Added status
}

//Medicine Store
final class MedicineStore: ObservableObject {
    @Published var medicines: [Medicine] = []
    
    init() {
        loadMedicines()
    }
    
    func saveMedicine(_ medicine: Medicine) {
        medicines.append(medicine)
        saveToDisk()
    }
    
    func updateMedicineStatus(id: UUID, status: MedicineStatus) {
        if let index = medicines.firstIndex(where: { $0.id == id }) {
            medicines[index].status = status
            saveToDisk()
        }
    }
    
    func deleteMedicine(at offsets: IndexSet) {
        medicines.remove(atOffsets: offsets)
        saveToDisk()
    }
    
    private func loadMedicines() {
        if let data = UserDefaults.standard.data(forKey: "medicines"),
           let saved = try? JSONDecoder().decode([Medicine].self, from: data) {
            medicines = saved
        }
    }
    
    private func saveToDisk() {
        if let data = try? JSONEncoder().encode(medicines) {
            UserDefaults.standard.set(data, forKey: "medicines")
        }
    }
}

struct save: View {
    var body: some View {
        Text("Data Store")
    }
}

#Preview {
    save()
}
