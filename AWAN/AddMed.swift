//
//  AddMed.swift
//  AWAN
//
//  Created by شذا on 21/02/1448 AH.
//


import SwiftUI
import PhotosUI

struct AddMed: View {

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
    @State private var everyHours = 8
    @State private var afterFood = true

    @State private var showSaved = false

    let doseOptions = ["1", "2", "3", "Other"]

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

                    sectionTitle("Dose Times", "clock")
                    timeCard

                    sectionTitle("Every How Many Hours", "clock.arrow.circlepath")
                    hoursCard

                    afterFoodCard
                    saveButton

                }
                .padding(.horizontal, 20)
                .padding(.top, 4)
                .padding(.bottom, 24)
            }

            tabBar
        }
        // IMPORTANT: the background goes here, not as a ZStack layer.
        //
        // If you put Image("back").ignoresSafeArea() inside a ZStack,
        // the ZStack grows to match it and drags the rest of the content
        // up under the Dynamic Island / camera.
        // With .background() the image expands but the content stays
        // safely inside the safe area.
        .background(
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .alert("Tablets per dose", isPresented: $showCustomAlert){
            TextField("e.g. 4", text: $customDose)
                .keyboardType(.numberPad)
            Button("Done"){ }
            Button("Cancel", role: .cancel){ doseIndex = 0 }
        }
        .alert("Medicine saved ✓", isPresented: $showSaved){
            Button("OK"){ }
        }
        .onChange(of: photoItem){ _, newItem in
            Task{
                photoData = try? await newItem?.loadTransferable(type: Data.self)
            }
        }
    }


    // ──────────── Header ────────────

    var header: some View {
        VStack(alignment: .leading, spacing: 4){
            HStack(spacing: 8){
                Image(systemName: "pills.fill")
                    .font(.system(size: 22))
                    .foregroundColor(mainBlue)

                Text("Add Medicine")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(mainBlue)

                Spacer()

                Button(action: {

                }){
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(mainBlue)
                }
            }

            Text("Add your medicine and set the dose and times that suit you.")
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 14)
    }


    // ──────────── Cards ────────────

    var nameCard: some View {
        HStack(spacing: 12){
            iconBox("cross.vial.fill")

            VStack(alignment: .leading, spacing: 4){
                Text("Medicine Name")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(mainBlue)

                // $medName with the dollar sign = the value + permission to edit it
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
                    Text("Medicine Image")
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
        }
    }

    var doseCard: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Tablets per Dose")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(mainBlue)

            HStack(spacing: 8){
                // ForEach repeats the same button for every option
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
                    }
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

            Text("First Time")
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

    var hoursCard: some View {
        HStack{
            Button(action: {
                if everyHours > 1 { everyHours -= 1 }
            }){
                Image(systemName: "minus.circle")
                    .font(.system(size: 28))
                    .foregroundColor(mainBlue)
            }

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

            Text("Take After Food")
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
                Text("Save Medicine")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(mainBlue)
            .cornerRadius(15)
        }
        .padding(.top, 6)
        .disabled(medName.isEmpty)
        .opacity(medName.isEmpty ? 0.5 : 1)
    }


    // ──────────── Reusable pieces ────────────
    // Written once instead of repeating the same lines in every card

    /// The small white square that holds an icon
    func iconBox(_ name: String) -> some View {
        Image(systemName: name)
            .font(.system(size: 19))
            .foregroundColor(mainBlue)
            .frame(width: 42, height: 42)
            .background(Color.white.opacity(0.85))
            .cornerRadius(12)
    }

    /// The small label above a group of cards
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

    /// Bottom tab bar: Medicines / Appointments / List
    var tabBar: some View {
        HStack{
            tabItem("Medicines", "pills.fill", isSelected: true)
            tabItem("Appointments", "calendar", isSelected: false)
            tabItem("List", "square.3.layers.3d", isSelected: false)
        }
        .padding(5)
        .background(Color.white)
        .cornerRadius(32)
        .shadow(color: .black.opacity(0.1), radius: 8, y: 3)
        .padding(.horizontal, 20)
        .padding(.top, 6)
    }

    func tabItem(_ title: String, _ icon: String, isSelected: Bool) -> some View {
        VStack(spacing: 3){
            Image(systemName: icon)
                .font(.system(size: 19))
            Text(title)
                .font(.system(size: 11))
                .lineLimit(1)
                // shrinks the text instead of truncating it ("Appointments" is long)
                .minimumScaleFactor(0.8)
        }
        .foregroundColor(mainBlue)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 9)
        .background(isSelected ? Color.gray.opacity(0.18) : Color.clear)
        .cornerRadius(24)
    }


    // ──────────── Saving ────────────

    func saveMedicine() {
        // Real count: if "Other" was picked take the typed number, otherwise index + 1
        let count = doseIndex == 3 ? (Int(customDose) ?? 1) : doseIndex + 1

        // For now we print the values to the Console to confirm they arrived correctly.
        // This is where you would later connect real storage (SwiftData or a database).
        print("Name: \(medName)")
        print("Tablets per dose: \(count)")
        print("First time: \(firstTime.formatted(date: .omitted, time: .shortened))")
        print("Every: \(everyHours) hours")
        print("After food: \(afterFood)")

        showSaved = true
    }
}

#Preview {
    AddMed()
}
