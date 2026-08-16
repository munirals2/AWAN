//
//  AddMed.swift
//  AWAN
//
//  Created by شذا on 21/02/1448 AH.
//


import SwiftUI
import PhotosUI

struct AddMed: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: MedicineStore

    // App colors — same AWAN blue you used on the home page
    let mainBlue = Color(red: 96/255, green: 157/255, blue: 220/255)
    let cardBlue = Color(red: 222/255, green: 235/255, blue: 248/255)

    // @State = a value this screen owns. Changing it redraws the UI automatically.
    @State private var medName = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var photoData: Data?

    @State private var doseIndex = 1          // 1, 2, 3, Other  (1 = index 0)
    @State private var customDose = ""
    @State private var showCustomAlert = false

    @State private var firstTime = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date()

    @State private var frequencyType: FrequencyType = .daily
    @State private var everyHours = 8
    @State private var selectedWeekdays: Set<Int> = []   // 1=Sun ... 7=Sat

    @State private var afterFood = true

    @State private var showSaved = false

    let doseOptions = [
        "1",
        "2",
        "3",
        String(localized: "Other")
    ]
    // Weekday buttons shown Sun...Sat, matching Calendar's 1-7 weekday numbering
    let weekdaySymbols = [
        String(localized: "SunLetter"),
        String(localized: "MonLetter"),
        String(localized: "TueLetter"),
        String(localized: "WedLetter"),
        String(localized: "ThuLetter"),
        String(localized: "FriLetter"),
        String(localized: "SatLetter")
    ]

    var body: some View {
        // The header is OUTSIDE the ScrollView on purpose:
        // it stays fixed and the cards scroll underneath it.
        VStack(spacing: 0){

            header

            ScrollView{
                VStack(spacing: 14){

                    nameCard
                    imageCard
                    doseCard

                    sectionTitle("First dose time", "clock")
                    timeCard

                    sectionTitle("Repeats", "repeat")
                    frequencyPicker

                    // Only one of these shows, depending on the picked frequency
                    if frequencyType == .hourly {
                        hoursCard
                    } else if frequencyType == .weekly {
                        weekdayCard
                    }

                    afterFoodCard
                    saveButton

                }
                .padding(.horizontal, 20)
                .padding(.top, 4)
                .padding(.bottom, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.interactively)
        }
        .background(
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .allowsHitTesting(false)
        )
        .alert("Tablets per dose", isPresented: $showCustomAlert){
            TextField("e.g. 4", text: $customDose)
                .keyboardType(.numberPad)
            Button("Done"){ }
            Button("Cancel", role: .cancel){ doseIndex = 0 }
        }
        .alert("Medicine saved", isPresented: $showSaved){
            Button("OK"){ dismiss() }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onChange(of: photoItem){ _, newItem in
            Task{
                photoData = try? await newItem?.loadTransferable(type: Data.self)
            }
        }
    }


    // ──────────── Header (matches "New Appointment" style: circular back button + centered title) ────────────

    var header: some View {
        VStack(alignment: .leading, spacing: 12){

            // Top row: circular back button + centered title
            ZStack {
        

                HStack {
                    Button(action: {
                        dismiss()
                    }){
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(mainBlue)
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)

                    Spacer()
                }
            }
            .padding(.top, 20)

            // Icon + description row
            HStack(spacing: 8){
                Image(systemName: "pills.fill")
                    .font(.system(size: 22))
                    .foregroundColor(mainBlue)

                VStack(alignment: .leading, spacing: 4){
                    Text("Add Medicine")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(mainBlue)

                    Text("Add your medicine and set the dose and times that suit you.")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }

                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 14)
    }


    // ──────────── Cards ────────────

    var nameCard: some View {
        HStack(spacing: 12){
            iconBox("cross.vial.fill")

            VStack(alignment: .leading, spacing: 4){
                Text("Medicine name")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(mainBlue)

                TextField("Type the medicine name", text: $medName)
                    .font(.system(size: 14))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(cardBlue)
        .cornerRadius(18)
    }

    var imageCard: some View {
        PhotosPicker(selection: $photoItem, matching: .images){
            HStack(spacing: 12){
                iconBox("photo")

                VStack(alignment: .leading, spacing: 4){
                    Text("Medicine image")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(mainBlue)

                    if let photoData, let ui = UIImage(data: photoData) {
                        Image(uiImage: ui)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 56, height: 56)
                            .cornerRadius(10)
                    } else {
                        Text("Add a photo of the medicine")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(cardBlue)
            .cornerRadius(18)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    var doseCard: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Tablets per Dose")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(mainBlue)

            HStack(spacing: 8){
                ForEach(doseOptions.indices, id: \.self){ i in
                    Button(action: {
                        doseIndex = i
                        if i == 3 { showCustomAlert = true }
                    }){
                        Text(doseOptions[i])
                            .font(.system(size: 15))
                            .foregroundColor(doseIndex == i ? .white : mainBlue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 38)
                            .background(doseIndex == i ? mainBlue : Color.white.opacity(0.7))
                            .cornerRadius(10)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(cardBlue)
        .cornerRadius(18)
    }

    var timeCard: some View {
        HStack(spacing: 12){
            iconBox("clock.fill")

            Text("First time")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(mainBlue)

            Spacer()

            DatePicker("", selection: $firstTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(cardBlue)
        .cornerRadius(18)
    }

    // Daily / Weekly / Hourly segmented picker
    var frequencyPicker: some View {
        HStack(spacing: 8){
            ForEach(FrequencyType.allCases, id: \.self){ type in
                Button(action: {
                    frequencyType = type
                }){
                    Text(type.label)
                        .font(.system(size: 15))
                        .foregroundColor(frequencyType == type ? .white : mainBlue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 38)
                        .background(frequencyType == type ? mainBlue : Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(cardBlue)
        .cornerRadius(18)
    }

    // Shown only when frequencyType == .weekly
    var weekdayCard: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Which days")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(mainBlue)

            HStack(spacing: 6){
                ForEach(1...7, id: \.self){ weekday in
                    let isSelected = selectedWeekdays.contains(weekday)
                    Button(action: {
                        if isSelected {
                            selectedWeekdays.remove(weekday)
                        } else {
                            selectedWeekdays.insert(weekday)
                        }
                    }){
                        Text(weekdaySymbols[weekday - 1])
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(isSelected ? .white : mainBlue)
                            .frame(width: 36, height: 36)
                            .background(isSelected ? mainBlue : Color.white.opacity(0.7))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
            }

            if selectedWeekdays.isEmpty {
                Text("Pick at least one day")
                    .font(.system(size: 12))
                    .foregroundColor(.red.opacity(0.7))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(cardBlue)
        .cornerRadius(18)
    }

    // Shown only when frequencyType == .hourly
    var hoursCard: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Every how many hours")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(mainBlue)

            HStack{
                Button(action: {
                    if everyHours > 1 { everyHours -= 1 }
                }){
                    Image(systemName: "minus.circle")
                        .font(.system(size: 28))
                        .foregroundColor(mainBlue)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                Spacer()

                Text("\(everyHours) hours")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(mainBlue)

                Spacer()

                Button(action: {
                    if everyHours < 24 { everyHours += 1 }
                }){
                    Image(systemName: "plus.circle")
                        .font(.system(size: 28))
                        .foregroundColor(mainBlue)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(cardBlue)
        .cornerRadius(18)
    }

    var afterFoodCard: some View {
        HStack(spacing: 12){
            iconBox("fork.knife")

            Text("Take after meal")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(mainBlue)

            Spacer()

            Toggle("", isOn: $afterFood)
                .labelsHidden()
                .tint(mainBlue)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(cardBlue)
        .cornerRadius(18)
    }

    var saveButton: some View {
        Button(action: {
            saveMedicine()
        }){
            HStack(spacing: 8){
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .bold))
                Text("Save medicine")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(mainBlue)
            .cornerRadius(15)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .padding(.top, 6)
        .disabled(isSaveDisabled)
        .opacity(isSaveDisabled ? 0.5 : 1)
    }

    // Save button is disabled if name is empty, or weekly with no days picked
    private var isSaveDisabled: Bool {
        if medName.isEmpty { return true }
        if frequencyType == .weekly && selectedWeekdays.isEmpty { return true }
        return false
    }


    // ──────────── Reusable pieces ────────────

    func iconBox(_ name: String) -> some View {
        Image(systemName: name)
            .font(.system(size: 19))
            .foregroundColor(mainBlue)
            .frame(width: 42, height: 42)
            .background(Color.white.opacity(0.85))
            .cornerRadius(12)
    }

    func sectionTitle(_ text: String, _ icon: String) -> some View {
        HStack(spacing: 6){
            Image(systemName: icon)
                .font(.system(size: 14))
            Text(text)
                .font(.system(size: 15))
                .fontWeight(.semibold)
        }
        .foregroundColor(mainBlue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 4)
    }

    // ──────────── Saving ────────────

    func saveMedicine() {
        // Real count: if "Other" was picked take the typed number, otherwise index + 1
        let count = doseIndex == 3 ? (Int(customDose) ?? 1) : doseIndex + 1

        let newMedicine = Medicine(
            name: medName,
            doseCount: count,
            firstTime: firstTime,
            frequencyType: frequencyType,
            everyHours: everyHours,
            weeklyDays: Array(selectedWeekdays).sorted(),
            afterFood: afterFood,
            imageData: photoData
        )

        store.saveMedicine(newMedicine)
        showSaved = true
    }
}

#Preview {
    NavigationStack{
        AddMed(store: MedicineStore())
    }
}
