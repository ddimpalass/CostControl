//
//  AddPeriod.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct AddPeriod: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var name: String = ""
    @State private var limit: String = ""
    @State private var numberOfDays: String = ""

    var body: some View {
        VStack(spacing: -16) {
            CustomTextField(text: $name, placeholder: "Название периода")
            CustomTextField(text: $limit, placeholder: "Лимит периода")
                .keyboardType(.numberPad)
            CustomTextField(text: $numberOfDays, placeholder: "На сколько дней")
                .keyboardType(.numberPad)
            CustomButton(systemName: "plus", color: .white, foregroundColor: .gray, action: {
                presentationMode.wrappedValue.dismiss()

                StorageManager.shared.addPeriod(name: name, limit: limit, numberOfDays: numberOfDays)
            })
            .padding()
            Spacer()

        }
        .background(Color.gray)
        .ignoresSafeArea()
    }
}
