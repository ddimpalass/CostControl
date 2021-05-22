//
//  AddSpendView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct AddSpendView: View {
    @Environment(\.presentationMode) private var presentationMode

    let period: Period?
    let spend: Spend?
    
    @State private var name: String = ""
    @State private var cost: String = ""
    
    init(period: Period?, spend: Spend?) {
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
                    SpendStorageManager.shared.updateSpend(spend: spend!, name: name, cost: cost)
                } else if period != nil{
                    SpendStorageManager.shared.addSpend(period: period!, name: name, cost: cost)
                }
            })
            .padding()
            Spacer()
        }
        .background(Color.gray)
        .ignoresSafeArea()
    }
}

