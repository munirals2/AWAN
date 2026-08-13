//
//  SchedulePage.swift
//  AWAN
//

import SwiftUI

struct SchedulePage: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: AppointmentStore
    var appointmentToEdit: Appointment?
    
    @State private var hospitalName: String = ""
    @State private var visitReason: String = ""
    @State private var reminderOn: Bool = true
    @State private var selectedDate: Date? = nil
    @State private var selectedTime: Date = {
        var comps = DateComponents()
        comps.hour = 10
        comps.minute = 0
        return Calendar.current.date(from: comps) ?? Date()
    }()
    @State private var showTimePicker: Bool = false

    @State private var currentMonth: Date = {
        let calendar = Calendar.current
        let today = Date()
        return calendar.date(from: calendar.dateComponents([.year, .month], from: today)) ?? today
    }()
    
    @State private var showMonthPicker: Bool = false
    @State private var pickerMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var pickerYear: Int = Calendar.current.component(.year, from: Date())

    let accentColor = Color(red: 0.38, green: 0.62, blue: 0.86)
    let fieldBackground = Color(red: 0.90, green: 0.93, blue: 0.98)
    private let calendar = Calendar.current

    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: selectedTime)
    }

    private var monthTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }

    private var gridDays: [(date: Date, inCurrentMonth: Bool)] {
        guard let monthRange = calendar.range(of: .day, in: .month, for: currentMonth),
              let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))
        else { return [] }

        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)
        let leadingBlanks = firstWeekday - 1

        var days: [(Date, Bool)] = []

        if leadingBlanks > 0,
           let prevMonth = calendar.date(byAdding: .month, value: -1, to: firstOfMonth),
           let prevMonthRange = calendar.range(of: .day, in: .month, for: prevMonth) {
            let prevMonthDayCount = prevMonthRange.count
            for i in stride(from: leadingBlanks, to: 0, by: -1) {
                let day = prevMonthDayCount - i + 1
                var comps = calendar.dateComponents([.year, .month], from: prevMonth)
                comps.day = day
                if let date = calendar.date(from: comps) {
                    days.append((date, false))
                }
            }
        }

        for day in monthRange {
            var comps = calendar.dateComponents([.year, .month], from: firstOfMonth)
            comps.day = day
            if let date = calendar.date(from: comps) {
                days.append((date, true))
            }
        }

        return days
    }

    private func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }

    var body: some View {
        // Header is OUTSIDE the ScrollView on purpose, same as AddMed:
        // it stays fixed and the content scrolls underneath it.
        VStack(spacing: 0) {

            header

            ScrollView {
                VStack {

                    // Calendar card
                    RoundedRectangle(cornerRadius: 20)
                        .fill(fieldBackground)
                        .frame(height: 380)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.11), radius: 8, x: 0, y: 4)
                        .overlay(
                            VStack(spacing: 14) {
                                HStack {
                                    Button {
                                        changeMonth(by: -1)
                                    } label: {
                                        Image(systemName: "chevron.backward").foregroundStyle(accentColor).bold()
                                    }
                                    .offset(x: 15)
                                    Spacer()
                                    Text(monthTitle)
                                        .foregroundStyle(accentColor).bold()
                                        .onTapGesture {
                                            pickerMonth = calendar.component(.month, from: currentMonth)
                                            pickerYear = calendar.component(.year, from: currentMonth)
                                            showMonthPicker = true
                                        }
                                    Spacer()
                                    Button {
                                        changeMonth(by: 1)
                                    } label: {
                                        Image(systemName: "chevron.forward").foregroundStyle(accentColor).bold()
                                    }
                                    .offset(x: -15)
                                }

                                HStack {
                                    ForEach(["Sun","Mon","Tue","Wed","Thu","Fri","Sat"], id: \.self) { day in
                                        Text(day).frame(maxWidth: .infinity).foregroundStyle(accentColor)
                                    }
                                }
                                .font(.caption)

                                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                                LazyVGrid(columns: columns, spacing: 12) {
                                    ForEach(gridDays, id: \.date) { item in
                                        let dayNumber = calendar.component(.day, from: item.date)
                                        let isSelected = selectedDate != nil && calendar.isDate(item.date, inSameDayAs: selectedDate!)

                                        Text("\(dayNumber)")
                                            .frame(width: 32, height: 32)
                                            .foregroundStyle(
                                                isSelected ? .white :
                                                (item.inCurrentMonth ? .black : .gray.opacity(0.4))
                                            )
                                            .background(
                                                Circle().fill(isSelected ? accentColor : Color.clear)
                                            )
                                            .onTapGesture {
                                                if item.inCurrentMonth {
                                                    selectedDate = item.date
                                                }
                                            }
                                    }
                                }
                            }
                            .padding(),
                            alignment: .top
                        )

                    // Hospital name field
                    appointmentField(placeholder: "Enter hospital name", label: "Hospital name", icon: "building.2.fill", text: $hospitalName)

                    // Time field
                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(Circle().fill(accentColor))
                        Text("Time").foregroundStyle(accentColor).bold()
                        Spacer()
                        Text(formattedTime)
                            .padding(.horizontal, 14).padding(.vertical, 8)
                            .background(accentColor)
                            .foregroundStyle(.white)
                            .clipShape(Capsule())
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(fieldBackground))
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .onTapGesture {
                        showTimePicker = true
                    }

                    // Reason field
                    appointmentField(placeholder: "Enter visit reason", label: "Visit reason", icon: "clipboard.fill", text: $visitReason)

                    // Reminder toggle
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(Circle().fill(accentColor))
                        VStack(alignment: .leading) {
                            Text("Enable appointment reminder").foregroundStyle(accentColor).bold()
                            Text("We'll remind you 15 minutes before your appointment")
                                .font(.caption).foregroundStyle(.gray)
                        }
                        Spacer()
                        Toggle("", isOn: $reminderOn)
                            .labelsHidden()
                            .tint(accentColor)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(fieldBackground))
                    .padding(.horizontal)
                    .padding(.top, 8)

                    // Save button
                    Button {
                        guard let date = selectedDate else {
                            return
                        }

                        if let existingAppointment = appointmentToEdit {
                                
                                let updatedAppointment = Appointment(
                                    id: existingAppointment.id,
                                    date: date,
                                    time: selectedTime,
                                    hospitalName: hospitalName,
                                    visitReason: visitReason,
                                    reminderOn: reminderOn,
                                    isConfirmed: existingAppointment.isConfirmed
                                )
                                
                                store.updateAppointment(updatedAppointment)
                                
                            } else {
                                
                                let newAppointment = Appointment(
                                    date: date,
                                    time: selectedTime,
                                    hospitalName: hospitalName,
                                    visitReason: visitReason,
                                    reminderOn: reminderOn
                                )
                                
                                store.saveAppointment(newAppointment)
                            }

                            dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                            Text("Save appointment").bold()
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 16).fill(accentColor))
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .padding(.bottom, 54)
                    .disabled(selectedDate == nil || hospitalName.isEmpty || visitReason.isEmpty)
                    .opacity((selectedDate == nil || hospitalName.isEmpty || visitReason.isEmpty) ? 0.5 : 1)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollIndicators(.hidden)
        }
        .background(
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .allowsHitTesting(false)
        )
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            if let appointment = appointmentToEdit {
                hospitalName = appointment.hospitalName
                visitReason = appointment.visitReason
                selectedDate = appointment.date
                selectedTime = appointment.time
                reminderOn = appointment.reminderOn
            }
        }
        .sheet(isPresented: $showTimePicker) {
            
            VStack {
                HStack {
                    Spacer()
                    Button("Done") {
                        showTimePicker = false
                    }
                    .bold()
                    .foregroundStyle(accentColor)
                    .padding()
                }
                DatePicker("Select time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                Spacer()
            }
            .presentationDetents([.height(300)])
        }
        .sheet(isPresented: $showMonthPicker) {
            VStack {
                HStack {
                    Spacer()
                    Button("Done") {
                        var comps = DateComponents()
                        comps.year = pickerYear
                        comps.month = pickerMonth
                        comps.day = 1
                        if let newDate = calendar.date(from: comps) {
                            currentMonth = newDate
                        }
                        showMonthPicker = false
                    }
                    .bold()
                    .foregroundStyle(accentColor)
                    .padding()
                }
                HStack {
                    Picker("Month", selection: $pickerMonth) {
                        ForEach(1...12, id: \.self) { month in
                            Text(calendar.monthSymbols[month - 1]).tag(month)
                        }
                    }
                    .pickerStyle(.wheel)

                    Picker("Year", selection: $pickerYear) {
                        ForEach(2020...2035, id: \.self) { year in
                            Text(String(year)).tag(year)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                Spacer()
            }
            .presentationDetents([.height(300)])
        }
    }

    // ──────────── Header

    var header: some View {
        VStack(alignment: .leading, spacing: 0) {

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(accentColor)
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                }
                .buttonStyle(.plain)

            }
            .padding(.top, 20)

            HStack {
                Image("schedulee").resizable().scaledToFit().frame(width: 50, height: 50).padding()

                VStack(alignment: .leading) {
                    Text("Add an appointment")
                        .padding(.trailing)
                        .foregroundStyle(accentColor).bold()
                    Text("Add your appointment details to remind you at the right time.")
                        .padding(.trailing).foregroundStyle(.gray).font(.caption)
                }
                
            }
        }
        .padding(.horizontal)
        .offset(y: -10)
    }

    @ViewBuilder
    private func appointmentField(placeholder: String, label: String, icon: String, text: Binding<String>) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(.white)
                .padding(8)
                .background(Circle().fill(accentColor))
            Text(label).foregroundStyle(accentColor).bold()
            TextField(placeholder, text: text)
                .padding(.leading, 8)
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(fieldBackground))
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
    NavigationStack {
        SchedulePage(store: AppointmentStore())
    }
}
