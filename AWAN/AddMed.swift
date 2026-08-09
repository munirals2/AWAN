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
        .alert("Medicine saved ✓", isPresented: $showSaved){
            Button("OK"){ }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onChange(of: photoItem){ _, newItem in
            Task{
                photoData = try? await newItem?.loadTransferable(type: Data.self)
            }
        }
    }


    // ──────────── Header ────────────
    // The back button uses dismiss() — NOT NavigationLink.
    // dismiss() just closes AddMed and returns to whichever screen
    // was already on the stack (e.g. the MyMedicineView you opened
    // AddMed from). It does not create anything new.
    //
    // Using NavigationLink(destination: MyMedicineView()) here was
    // the bug: it PUSHES a brand new MyMedicineView onto the stack
    // every time you tap the back arrow. That new pushed screen has
    // no idea it's a "duplicate" — SwiftUI automatically gives every
    // pushed screen its own system back button, which is why a round
    // "<" button was appearing on MyMedicineView even though you
    // never added one there yourself.

    var header: some View {
        VStack(alignment: .leading, spacing: 4){
            HStack {
                Button(action: {
                    dismiss()
                }){
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(mainBlue).bold()
                }
                .buttonStyle(.plain)
                Spacer()
            }
            .padding(.top, 20)

            HStack(spacing: 8){
                Image(systemName: "pills.fill")
                    .font(.system(size: 22))
                    .foregroundColor(mainBlue)

                Text("Add Medicine")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(mainBlue)

                Spacer()

            }

            Text("Add your medicine and set the dose and times that suit you.")
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .padding(.horizontal, 20)
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
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .padding(.top, 6)
        .disabled(medName.isEmpty)
        .opacity(medName.isEmpty ? 0.5 : 1)
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
        let count = doseIndex == 3 ? (Int(customDose) ?? 1) : doseIndex + 1

        print("Name: \(medName)")
        print("Tablets per dose: \(count)")
        print("First time: \(firstTime.formatted(date: .omitted, time: .shortened))")
        print("Every: \(everyHours) hours")
        print("After food: \(afterFood)")

        showSaved = true
    }
}

#Preview {
    NavigationStack{
        AddMed()
    }
}
