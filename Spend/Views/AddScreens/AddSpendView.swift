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
        VStack() {
            CustomTextField(text: $viewModel.name, placeholder: "Название траты")
            CustomTextField(text: $viewModel.cost, placeholder: "Сумма траты")
                .keyboardType(.numberPad)
            CustomButton(systemName: viewModel.spendIsValid ? "plus" : "multiply",
                         color: viewModel.spendIsValid ? Color("LightTextColor") : .red,
                         foregroundColor: Color("MainColor"),
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
        .background(LinearGradient.gradientWithMainColor)
        .ignoresSafeArea()
    }
}

