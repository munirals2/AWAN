import WidgetKit
import SwiftUI

// MARK: - Entry

struct AwanEntry: TimelineEntry {
    let date: Date
    
    let medicineName: String
    let medicineTime: String
    
    let appointmentDate: String
    let appointmentHospital: String
}

// MARK: - Provider

struct AwanProvider: TimelineProvider {
    
    // Placeholder
    func placeholder(in context: Context) -> AwanEntry {
        AwanEntry(
            date: Date(),
            medicineName: "Metformin",
            medicineTime: "11:30 AM",
            appointmentDate: "22 August",
            appointmentHospital: "Al Habib Hospital"
        )
    }
    
    // Snapshot
    func getSnapshot(
        in context: Context,
        completion: @escaping (AwanEntry) -> Void
    ) {
        completion(loadEntry())
    }
    
    // Timeline
    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<AwanEntry>) -> Void
    ) {
        
        let entry = loadEntry()
        
        let nextUpdate = Calendar.current.date(
            byAdding: .minute,
            value: 15,
            to: Date()
        )!
        
        let timeline = Timeline(
            entries: [entry],
            policy: .after(nextUpdate)
        )
        
        completion(timeline)
    }
    
    // MARK: - Load Data From App Group
    
    private func loadEntry() -> AwanEntry {
        
        let defaults = UserDefaults(
            suiteName: "group.com.awan.shared"
        )
        
        let medicineName =
            defaults?.string(forKey: "widgetMedicineName")
            ?? "Metformin"
        
        let medicineTime =
            defaults?.string(forKey: "widgetMedicineTime")
            ?? "11:30 AM"
        
        let appointmentDate =
            defaults?.string(forKey: "widgetAppointmentDate")
            ?? "No upcoming appointment"
        
        let appointmentHospital =
            defaults?.string(forKey: "widgetAppointmentHospital")
            ?? "No hospital"
        
        return AwanEntry(
            date: Date(),
            medicineName: medicineName,
            medicineTime: medicineTime,
            appointmentDate: appointmentDate,
            appointmentHospital: appointmentHospital
        )
    }
}


// MARK: - Widget View

// MARK: - Widget View

struct AwanWidgetEntryView: View {
    
    var entry: AwanProvider.Entry
    
    var body: some View {
        
        HStack(spacing: 20) {
            
            // MARK: Next Medicine
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(LocalizedStringKey("Next Medicine"))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white.opacity(0.9))
                
                Text(entry.medicineName)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(entry.medicineTime)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
            }
            
            // Divider
            
            Rectangle()
                .fill(Color.white.opacity(0.3))
                .frame(width: 1)
            
            // MARK: Next Appointment
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(LocalizedStringKey("Next Appointment"))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white.opacity(0.9))
                
                Text(entry.appointmentDate)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(entry.appointmentHospital)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(1)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .leading
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .containerBackground(
            Color(
                red: 150 / 255,
                green: 201 / 255,
                blue: 246 / 255
            ),
            for: .widget
        )
    }
}

// MARK: - Widget

struct awanwidget: Widget {
    
    let kind: String = "awanwidget"
    
    var body: some WidgetConfiguration {
        
        StaticConfiguration(
            kind: kind,
            provider: AwanProvider()
        ) { entry in
            
            AwanWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("AWAN")
        .description(
            "Shows your next medicine and appointment."
        )
        .supportedFamilies([
            .systemMedium
        ])
    }
}


// MARK: - Preview

#Preview(as: .systemMedium) {
    awanwidget()
} timeline: {
    
    AwanEntry(
        date: .now,
        medicineName: "Metformin",
        medicineTime: "11:30 AM",
        appointmentDate: "22 August",
        appointmentHospital: "Al Habib Hospital"
    )
}
