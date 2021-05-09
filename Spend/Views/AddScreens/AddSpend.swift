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
    
    @State private var name: String = ""
    @State private var cost: String = ""
    
    var body: some View {
        VStack(spacing: -16) {
            CustomTextField(text: $name, placeholder: "Название траты")
            CustomTextField(text: $cost, placeholder: "Сумма траты")
                .keyboardType(.numberPad)
            CustomButton(systemName: "plus", color: .white, foregroundColor: .gray, action: {
                presentationMode.wrappedValue.dismiss()
                
                let newSpend = Spend(context: viewContext)
                newSpend.name = name
                newSpend.cost = Int32(cost) ?? 0
                newSpend.date = Date()
                
                period.addToSpends(newSpend)
                
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
        AddSpend(period: Period())
    }
}
