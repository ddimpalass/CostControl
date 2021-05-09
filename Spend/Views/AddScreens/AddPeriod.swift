//
//  AddPeriod.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct AddPeriod: View {
    @Environment(\.managedObjectContext) var viewContext
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
                
                let newPeriod = Period(context: viewContext)
                newPeriod.name = name
                newPeriod.limit = Int32(limit) ?? 0
                newPeriod.startDate = Date()
                newPeriod.endDate =  Calendar.current.date(byAdding: .day,
                                                       value: Int(numberOfDays) ?? 0,
                                                       to: newPeriod.startDate!)!
                PersistenceController.shared.save()
            })
            .padding()
            Spacer()

        }
        .background(Color.gray)
        .ignoresSafeArea()
    }
}


struct AddPeriod_Previews: PreviewProvider {
    static var previews: some View {
        AddPeriod()
    }
}
