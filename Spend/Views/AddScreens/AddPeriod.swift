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
    
    var period: Period?
    
    init(period: Period?) {
        self.period = period
        guard period != nil else { return }
        _name = State(wrappedValue: period!.name!)
        _limit = State(wrappedValue: String(period!.limit))
        let dayCount = Calendar.current.dateComponents([.day], from: period!.startDate!, to: period!.endDate!)
        _numberOfDays = State(wrappedValue: String(dayCount.day ?? 0))
    }

    var body: some View {
        VStack(spacing: -16) {
            CustomTextField(text: $name, placeholder: "Название периода")
            CustomTextField(text: $limit, placeholder: "Лимит периода")
                .keyboardType(.numberPad)
            CustomTextField(text: $numberOfDays, placeholder: "На сколько дней")
                .keyboardType(.numberPad)
            CustomButton(systemName: "plus", color: .white, foregroundColor: .gray, action: {
                presentationMode.wrappedValue.dismiss()
                if period != nil {
                    StorageManager.shared.updatePeriod(period: period!, name: name, limit: limit, numberOfDays: numberOfDays)
                } else {
                    StorageManager.shared.addPeriod(name: name, limit: limit, numberOfDays: numberOfDays)
                }
            })
            .padding()
            Spacer()

        }
        .background(Color.gray)
        .ignoresSafeArea()
    }
}
