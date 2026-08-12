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
        removeFinishedAppointments()
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
    func removeFinishedAppointments() {
        let today = Calendar.current.startOfDay(for: Date())

        appointments.removeAll { appointment in
            let appointmentDay = Calendar.current.startOfDay(for: appointment.date)
            return appointmentDay < today
        }

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

// How often the medicine repeats
enum FrequencyType: String, Codable, CaseIterable {
    case daily    // once every day, at firstTime
    case weekly   // on specific days of the week, at firstTime
    case hourly   // repeats every X hours starting at firstTime

    var label: String {
        switch self {
        case .daily: return "Daily"
        case .weekly: return "Weekly"
        case .hourly: return "Hourly"
        }
    }
}

//Medicine with Status
struct Medicine: Identifiable, Codable {
    var id = UUID()
    var name: String
    var doseCount: Int
    var firstTime: Date
    var frequencyType: FrequencyType = .daily
    var everyHours: Int = 8            // only used when frequencyType == .hourly
    var weeklyDays: [Int] = []         // Calendar weekday ints: 1=Sun ... 7=Sat, only used when .weekly
    var afterFood: Bool
    var imageData: Data?
    var status: MedicineStatus = .pending

    init(
        id: UUID = UUID(),
        name: String,
        doseCount: Int,
        firstTime: Date,
        frequencyType: FrequencyType = .daily,
        everyHours: Int = 8,
        weeklyDays: [Int] = [],
        afterFood: Bool,
        imageData: Data? = nil,
        status: MedicineStatus = .pending
    ) {
        self.id = id
        self.name = name
        self.doseCount = doseCount
        self.firstTime = firstTime
        self.frequencyType = frequencyType
        self.everyHours = everyHours
        self.weeklyDays = weeklyDays
        self.afterFood = afterFood
        self.imageData = imageData
        self.status = status
    }

    // Custom decoding so medicines saved before frequencyType existed
    // still load fine, defaulting to .daily instead of crashing.
    enum CodingKeys: String, CodingKey {
        case id, name, doseCount, firstTime, frequencyType, everyHours, weeklyDays, afterFood, imageData, status
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        name = try container.decode(String.self, forKey: .name)
        doseCount = try container.decode(Int.self, forKey: .doseCount)
        firstTime = try container.decode(Date.self, forKey: .firstTime)
        frequencyType = try container.decodeIfPresent(FrequencyType.self, forKey: .frequencyType) ?? .daily
        everyHours = try container.decodeIfPresent(Int.self, forKey: .everyHours) ?? 8
        weeklyDays = try container.decodeIfPresent([Int].self, forKey: .weeklyDays) ?? []
        afterFood = try container.decode(Bool.self, forKey: .afterFood)
        imageData = try container.decodeIfPresent(Data.self, forKey: .imageData)
        status = try container.decodeIfPresent(MedicineStatus.self, forKey: .status) ?? .pending
    }
}

//Medicine Store
final class MedicineStore: ObservableObject {
    @Published var medicines: [Medicine] = []
    
    init() {
        loadMedicines()
        removeFinishedMedicines()
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
    func removeFinishedMedicines() {
        let today = Calendar.current.startOfDay(for: Date())

        medicines.removeAll { medicine in
            let medicineDay = Calendar.current.startOfDay(for: medicine.firstTime)
            return medicineDay < today
        }

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
