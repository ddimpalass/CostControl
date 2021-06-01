//
//  AddPeriodView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct AddPeriodView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var viewModel: AddPeriodViewModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack() {
                CustomTextField(text: $viewModel.name, placeholder: "Название периода")
                    .disableAutocorrection(true)
                CustomTextField(text: $viewModel.limit, placeholder: "Бюджет периода")
                    .keyboardType(.numberPad)
                CustomTextField(text: $viewModel.numberOfDays, placeholder: "На сколько дней")
                    .keyboardType(.numberPad)
                CustomButton(systemName: viewModel.periodIsValid ? "plus" : "multiply",
                             color: viewModel.periodIsValid ? Color("BackgroundColor") : Color("AccentColor"),
                             foregroundColor: viewModel.periodIsValid ? Color("AccentColor") : Color("BackgroundColor"),
                             action: {
                                if viewModel.periodIsValid {
                                    presentationMode.wrappedValue.dismiss()
                                    viewModel.periodAction()
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
