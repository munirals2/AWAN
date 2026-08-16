//
//  fourth.swift
//  AWAN
//
//  Created by rataj abdullah aldebeebi on 21/02/1448 AH.
//

import SwiftUI
import WidgetKit
import AVFoundation
struct HomeView: View {
    func updateWidget() {
        
        let defaults = UserDefaults(suiteName: "group.com.awan.shared")
        
        // Next Appointment
        if let appointment = nextAppointment {
            
            let appointmentDate = appointment.date.formatted(
                .dateTime
                    .day()
                    .month(.wide)
            )
            
            defaults?.set(
                appointmentDate,
                forKey: "widgetAppointmentDate"
            )
            
            defaults?.set(
                appointment.hospitalName,
                forKey: "widgetAppointmentHospital"
            )
            
            let time = appointment.time.formatted(
                date: .omitted,
                time: .shortened
                
            )
            
            defaults?.set(
                time,
                forKey: "widgetAppointmentTime"
            )
            
        } else {
            
            defaults?.set(
                "No upcoming appointment",
                forKey: "widgetAppointmentDate"
            )
            
            defaults?.set(
                "No hospital",
                forKey: "widgetAppointmentHospital"
            )
            
            defaults?.set(
                "",
                forKey: "widgetAppointmentTime"
            )
        }
        
        // Next Medicine
        if let medicine = nextMedicine {
            
            defaults?.set(
                medicine.name,
                forKey: "widgetMedicineName"
            )
            
            let medicineTime = medicine.firstTime.formatted(
                date: .omitted,
                time: .shortened
            )
            
            defaults?.set(
                medicineTime,
                forKey: "widgetMedicineTime"
            )
            
        } else {
            
            defaults?.set(
                "No upcoming medicine",
                forKey: "widgetMedicineName"
            )
            
            defaults?.set(
                "",
                forKey: "widgetMedicineTime"
            )
        }
        
        // Tell WidgetKit to refresh the widget
        WidgetCenter.shared.reloadAllTimelines()
    }
    @ObservedObject var store: AppointmentStore
    @ObservedObject var medicineStore: MedicineStore
    var nextAppointment: Appointment? {
        let now = Date()
        
        return store.appointments
            .filter {
                let appointmentDate = Calendar.current.date(
                    bySettingHour: Calendar.current.component(.hour, from: $0.time),
                    minute: Calendar.current.component(.minute, from: $0.time),
                    second: 0,
                    of: $0.date
                ) ?? $0.date
                
                return appointmentDate > now
            }
            .sorted { $0.date < $1.date }
            .first
    }
    var nextMedicine: Medicine? {
        let now = Date()
        
        return medicineStore.medicines
            .filter { $0.status == .pending }
            .sorted { medicine1, medicine2 in
                let date1 = Calendar.current.date(
                    bySettingHour: Calendar.current.component(.hour, from: medicine1.firstTime),
                    minute: Calendar.current.component(.minute, from: medicine1.firstTime),
                    second: 0,
                    of: now
                ) ?? medicine1.firstTime
                
                let date2 = Calendar.current.date(
                    bySettingHour: Calendar.current.component(.hour, from: medicine2.firstTime),
                    minute: Calendar.current.component(.minute, from: medicine2.firstTime),
                    second: 0,
                    of: now
                ) ?? medicine2.firstTime
                
                return date1 < date2
            }
            .first
    }
    
    @State private var showMedicineDetails = false
    @State private var showConfirmView = false
    @State private var speechSynthesizer = AVSpeechSynthesizer()
    
    func speakHomePage() {

        speechSynthesizer.stopSpeaking(at: .immediate)

        let dateText = Date().formatted(
            .dateTime
                .weekday(.wide)
                .day()
                .month(.wide)
        )

        speakText(dateText)

        speakText("Welcome")

        if let medicine = nextMedicine {

            let medicineTime = medicine.firstTime.formatted(
                date: .omitted,
                time: .shortened
            )

            speakText("Next medicine")

            speakText(medicine.name)

            speakText("At \(medicineTime)")

        } else {

            speakText("Next medicine. No upcoming medicine")
        }

        if let appointment = nextAppointment {

            let appointmentDate = appointment.date.formatted(
                .dateTime
                    .day()
                    .month(.wide)
            )

            let appointmentTime = appointment.time.formatted(
                date: .omitted,
                time: .shortened
            )

            speakText("Next appointment")

            speakText(appointmentDate)

            speakText("At \(appointmentTime)")

            speakText("Hospital")

            speakText(appointment.hospitalName)

        } else {

            speakText("Next appointment. No upcoming appointment")
        }
    }
    func speakText(_ text: String) {

        let utterance = AVSpeechUtterance(string: text)

        if text.range(
            of: "[\\u0600-\\u06FF]",
            options: .regularExpression
        ) != nil {

            utterance.voice = AVSpeechSynthesisVoice(
                language: "ar-SA"
            )

        } else {

            utterance.voice = AVSpeechSynthesisVoice(
                language: "en-US"
            )
        }

        utterance.rate = 0.42
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0

        speechSynthesizer.speak(utterance)
    }
    var body: some View {

        ZStack {

            // Background
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 30) {
                HStack {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text(Date(), format: .dateTime.weekday(.wide).day().month(.wide))
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text("Welcome")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(
                                Color(red: 96/255,
                                      green: 157/255,
                                      blue: 220/255)
                            )
                    }

                    Spacer()
                    Button {
                        speakHomePage()
                    } label: {
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.system(size: 24))
                    }
                    }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 70)

                Spacer()
                    .frame(height: 20)
                
                // MARK: - Medicine Card
                ZStack {
                    
                    Image("backg")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .shadow(color: .black.opacity(0.2),
                                radius: 10,
                                x: 0,
                                y: 8)
                        .offset(y: -70)
                        .overlay(
                            
                            HStack {
                                Spacer()
                                
                                HStack(spacing: 6) {
                                    
                                    Text("Next Medicine")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(
                                            Color(
                                                red: 96/255,
                                                green: 157/255,
                                                blue: 220/255
                                            )
                                        )
                                    
                                    Image(systemName: "clock.fill")
                                        .foregroundColor(
                                            Color(
                                                red: 96/255,
                                                green: 157/255,
                                                blue: 220/255
                                            )
                                        )
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .clipShape(Capsule())
                                .offset(x: -220)
                                .offset(y: -80)
                            }
                                .padding(.top, 18)
                                .padding(.trailing, 20),
                            alignment: .topTrailing
                        )
                    
                    
                    VStack(spacing: 18) {
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                
                                Text(
                                    nextMedicine?.name ?? "No upcoming medicine"
                                )
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(
                                    Color(
                                        red: 96/255,
                                        green: 157/255,
                                        blue: 220/255
                                    )
                                )
                                .lineLimit(2)
                                .minimumScaleFactor(0.9)
                                .offset(y: -50)
                                
                            }
                            
                            Spacer()
                            
                            Image("medicine")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 150)
                                .offset(y: -70)
                                .offset(x: 30)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 50)
                        
                        
                        Button(action: {
                            
                            showMedicineDetails = true
                            
                        }) {
                            
                            HStack(spacing: 8) {
                                
                                Text("Take Now")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                
                                Image(systemName: "bell")
                                
                            }
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
                        .offset(y: -115)
                        
                        Spacer(minLength: 25)
                    }
                }
                .frame(height: 220)
                // MARK: - Appointment Card
                ZStack {
                    
                    Image("backg")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .shadow(color: .black.opacity(0.2),
                                radius: 10,
                                x: 0,
                                y: 8)
                        .offset(y: -115)
                        .overlay(
                            HStack {
                                Spacer()
                                
                                HStack(spacing: 6) {
                                    
                                    Text("Next Appointment")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(
                                            Color(
                                                red: 96/255,
                                                green: 157/255,
                                                blue: 220/255
                                            )
                                        )
                                    
                                 
                                    
                                    Image(systemName: "calendar")
                                        .foregroundColor(
                                            Color(
                                                red: 96/255,
                                                green: 157/255,
                                                blue: 220/255
                                            )
                                        )
                                    
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .clipShape(Capsule())
                                .offset(x: -190)
                                .offset(y: -120)
                            }
                                .padding(.top, 18)
                                .padding(.trailing, 20),
                            alignment: .topTrailing
                        )
                    
                    VStack(spacing: 18) {
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Text(
                                    nextAppointment?.date.formatted(
                                        .dateTime.day().month(.wide)
                                    ) ?? "No upcoming appointment"
                                )
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(
                                    Color(
                                        red: 96/255,
                                        green: 157/255,
                                        blue: 220/255
                                    )
                                )
                                .lineLimit(2)
                                .minimumScaleFactor(0.9)
                                .fixedSize(horizontal: false, vertical: true)
                                    .offset(y: -90)
                                
                            }
                            
                            Spacer()
                            
                            Image("ca")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                                .offset(y: -120)
                                .offset(x:45)
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 50)
                        
                        Button(action: {
                            showConfirmView = true
                        }) {
                            
                            HStack(spacing: 8) {
                                
                                Text("Appointment Details")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Image(systemName: "calendar")
                                
                            }
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
                        .offset(y: -165)
                        
                        Spacer(minLength: 25)
                    }
                }
                .frame(height: 220)
                Spacer()
            }
            .padding(.horizontal, 20)
            .sheet(isPresented: $showMedicineDetails) {
                MedicineDetailsView(
                    medicineStore: medicineStore,
                    medicineID: nextMedicine?.id ?? UUID()
                )
                .presentationDetents([.height(600)])
                .presentationDragIndicator(.hidden)
            }
            }

            .sheet(isPresented: $showConfirmView) {
                ConfirmView(
                    store: store,
                    appointmentID: nextAppointment?.id ?? UUID()
                )
                .presentationDetents([.height(600)])
                .presentationDragIndicator(.hidden)
            }

            .onAppear {
                updateWidget()
            }
            }

        }
    


#Preview {
    HomeView(
        store: AppointmentStore(),
        medicineStore: MedicineStore()
    )
}
