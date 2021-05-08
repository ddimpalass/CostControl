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
        VStack {
            TextField("Название траты", text: $name)
                .font(.custom("Roboto-Light", size: 24))
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
            TextField("Сумма траты", value: $cost, formatter: NumberFormatter())
                .font(.custom("Roboto-Light", size: 24))
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
            CustomButton(systemName: "plus", color: .white, foregroundColor: .gray, action: {
                presentationMode.wrappedValue.dismiss()
                
                let newSpend = Spend(context: viewContext)
                newSpend.name = name
                newSpend.cost = Int32(cost) ?? 0
                newSpend.date = Date()
                
                period.addToSpends(newSpend)
                
                PersistenceController.shared.save()
            })
            Spacer()
        }
        .padding()
        .background(Color.gray)
        .ignoresSafeArea()
    }
}

struct AddSpend_Previews: PreviewProvider {
    static var previews: some View {
        AddSpend(period: Period())
    }
}
