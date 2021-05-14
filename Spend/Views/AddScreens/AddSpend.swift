//
//  AddSpend.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct AddSpend: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) private var presentationMode

    let period: Period
    let spend: Spend?
    
    @State private var name: String = ""
    @State private var cost: String = ""
    
    init(period: Period, spend: Spend?) {
        self.period = period
        self.spend = spend
        guard spend != nil else { return }
        _name = State(wrappedValue: spend!.name!)
        _cost = State(wrappedValue: String(spend!.cost))
    }
    
    var body: some View {
        VStack(spacing: -16) {
            CustomTextField(text: $name, placeholder: "Название траты")
            CustomTextField(text: $cost, placeholder: "Сумма траты")
                .keyboardType(.numberPad)
            CustomButton(systemName: "plus", color: .white, foregroundColor: .gray, action: {
                presentationMode.wrappedValue.dismiss()
                
                if spend != nil {
                    spend?.name = name
                    spend?.cost = Int32(cost) ?? 0
                } else {
                    let newSpend = Spend(context: viewContext)
                    newSpend.name = name
                    newSpend.cost = Int32(cost) ?? 0
                    newSpend.date = Date()
                    
                    period.addToSpends(newSpend)
                }
                
                PersistenceController.shared.save()
            })
            .padding()
            Spacer()
        }
        .background(Color.gray)
        .ignoresSafeArea()
    }
}

struct AddSpend_Previews: PreviewProvider {
    static var previews: some View {
        AddSpend(period: Period(), spend: nil)
    }
}
