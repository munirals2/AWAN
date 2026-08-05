//
//  SchedulePage.swift
//  AWAN
//

import SwiftUI

struct SchedulePage: View {
    @State private var hospitalName: String = ""
    @State private var visitReason: String = ""
    @State private var reminderOn: Bool = true
    @State private var selectedDay: Int = 20
    @State private var selectedTime: Date = {
        var comps = DateComponents()
        comps.hour = 10
        comps.minute = 0
        return Calendar.current.date(from: comps) ?? Date()
    }()
    @State private var showTimePicker: Bool = false

    let accentColor = Color(red: 0.38, green: 0.62, blue: 0.86)
    let fieldBackground = Color(red: 0.90, green: 0.93, blue: 0.98)

    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: selectedTime)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Image("back").resizable().scaledToFill().ignoresSafeArea()

                ScrollView {
                    VStack {
                        HStack {
                            Image(systemName: "chevron.backward")
                                .padding(.top, 20).padding()
                                .foregroundStyle(accentColor).bold()
                            Spacer()
                        }

                        HStack {
                            Image("schedulee").resizable().scaledToFit().frame(width: 50, height: 50).padding()

                            VStack(alignment: .leading) {
                                Text("Add an appointment")
                                    .padding(.trailing)
                                    .foregroundStyle(accentColor).bold()
                                Text("Add your appointment details to remind you at the right time.")
                                    .padding(.trailing).foregroundStyle(.gray).font(.caption)
                            }
                            Spacer()
                        }

                        // Calendar card
                        RoundedRectangle(cornerRadius: 20)
                            .fill(fieldBackground)
                            .frame(height: 380)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.11), radius: 8, x: 0, y: 4)
                            .overlay(
                                VStack(spacing: 14) {
                                    HStack {
                                        Image(systemName: "chevron.backward").foregroundStyle(accentColor).bold()
                                        Spacer()
                                        Text("May 2026").foregroundStyle(accentColor).bold()
                                        Spacer()
                                        Image(systemName: "chevron.forward").foregroundStyle(accentColor).bold()
                                    }

                                    HStack {
                                        ForEach(["Sun","Mon","Tue","Wed","Thu","Fri","Sat"], id: \.self) { day in
                                            Text(day).frame(maxWidth: .infinity).foregroundStyle(accentColor)
                                        }
                                    }
                                    .font(.caption)

                                    dayRow([27,28,29,30,1,2,3], grayedOut: [27,28,29,30])
                                    dayRow([4,5,6,7,8,9,10])
                                    dayRow([11,12,13,14,15,16,17])
                                    dayRow([18,19,20,21,22,23,24])
                                    dayRow([25,26,27,28,29,30,31])
                                }
                                .padding(),
                                alignment: .top
                            )

                        // Hospital name field
                        appointmentField(placeholder: "Enter hospital name", label: "Hospital name", icon: "building.2.fill", text: $hospitalName)

                        // Time field — now tappable
                        HStack {
                            Text(formattedTime)
                                .padding(.horizontal, 14).padding(.vertical, 8)
                                .background(accentColor)
                                .foregroundStyle(.white)
                                .clipShape(Capsule())
                            Spacer()
                            Text("Time").foregroundStyle(accentColor).bold()
                            Image(systemName: "clock.fill")
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(Circle().fill(accentColor))
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
                            Toggle("", isOn: $reminderOn)
                                .labelsHidden()
                                .tint(accentColor)
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("Enable appointment reminder").foregroundStyle(accentColor).bold()
                                Text("We'll remind you 15 minutes before your appointment").font(.caption).foregroundStyle(.gray)
                            }
                            Image(systemName: "bell.fill")
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(Circle().fill(accentColor))
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 16).fill(fieldBackground))
                        .padding(.horizontal)
                        .padding(.top, 8)

                        // Save button
                        Button {
                            // save action
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
                        .padding(.bottom, 24)
                    }
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
        }
    }

    // Reusable day row builder
    @ViewBuilder
    private func dayRow(_ numbers: [Int], grayedOut: [Int] = []) -> some View {
        HStack {
            ForEach(numbers, id: \.self) { number in
                Text("\(number)")
                    .frame(width: 32, height: 32)
                    .foregroundStyle(
                        selectedDay == number && !grayedOut.contains(number) ? .white :
                        (grayedOut.contains(number) ? .gray.opacity(0.4) : .black)
                    )
                    .background(
                        Circle().fill(
                            selectedDay == number && !grayedOut.contains(number) ? accentColor : Color.clear
                        )
                    )
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        if !grayedOut.contains(number) {
                            selectedDay = number
                        }
                    }
            }
        }
    }

    // Reusable field builder (hospital name / visit reason)
    @ViewBuilder
    private func appointmentField(placeholder: String, label: String, icon: String, text: Binding<String>) -> some View {
        HStack {
            TextField(placeholder, text: text)
            Spacer()
            Text(label).foregroundStyle(accentColor).bold()
            Image(systemName: icon)
                .foregroundStyle(.white)
                .padding(8)
                .background(Circle().fill(accentColor))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(fieldBackground))
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
    SchedulePage()
}
