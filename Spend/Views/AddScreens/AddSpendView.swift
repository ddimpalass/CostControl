//
//  AddSpendView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct AddSpendView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var viewModel: AddSpendViewModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack() {
                CustomTextField(text: $viewModel.name, placeholder: "Название траты")
                    .disableAutocorrection(true)
                CustomTextField(text: $viewModel.cost, placeholder: "Сумма траты")
                    .keyboardType(.numberPad)
                CustomButton(systemName: viewModel.spendIsValid ? "plus" : "multiply",
                             color: viewModel.spendIsValid ? Color("BackgroundColor") : Color("AccentColor"),
                             foregroundColor: viewModel.spendIsValid ? Color("AccentColor") : Color("BackgroundColor"),
                             action: {
                                if viewModel.spendIsValid {
                                    presentationMode.wrappedValue.dismiss()
                                    viewModel.spendAction()
                                }
                                presentationMode.wrappedValue.dismiss()
                             })
                    .animation(.default)
                Spacer()
            }
            .padding()
        }
    }
}

