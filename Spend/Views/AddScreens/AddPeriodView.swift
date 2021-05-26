//
//  AddPeriodView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct AddPeriodView: View {
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
        let dayCount = DateManager.shared.dayInPeriod(start: period!.startDate!, end: period!.endDate!)
        _numberOfDays = State(wrappedValue: String(dayCount))
    }

    var body: some View {
        ZStack {
            LinearGradient.gradientWithMainColor
                .ignoresSafeArea()
            VStack() {
                CustomTextField(text: $name, placeholder: "Название периода")
                CustomTextField(text: $limit, placeholder: "Лимит периода")
                    .keyboardType(.numberPad)
                CustomTextField(text: $numberOfDays, placeholder: "На сколько дней")
                    .keyboardType(.numberPad)
                CustomButton(systemName: "plus",
                             color: Color("LightTextColor"),
                             foregroundColor: Color("MainColor"),
                             action: {
                    presentationMode.wrappedValue.dismiss()
                    if period != nil {
                        PeriodStorageManager.shared.updatePeriod(period: period!, name: name, limit: limit, numberOfDays: numberOfDays)
                    } else {
                        PeriodStorageManager.shared.addPeriod(name: name, limit: limit, numberOfDays: numberOfDays)
                    }
                })
                Spacer()
            }
            .padding()
        }
    }
}
