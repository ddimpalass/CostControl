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
        VStack {
            TextField("Название периода", text: $name)
                .font(.custom("Roboto-Light", size: 24))
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
            TextField("Лимит периода", text: $limit)
                .font(.custom("Roboto-Light", size: 24))
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
            TextField("На сколько дней", text: $numberOfDays)
                .font(.custom("Roboto-Light", size: 24))
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
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
            Spacer()
        }
        .padding()
        .background(Color.gray)
        .ignoresSafeArea()
    }
}


struct AddPeriod_Previews: PreviewProvider {
    static var previews: some View {
        AddPeriod()
    }
}
