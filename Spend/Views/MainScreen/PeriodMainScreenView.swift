//
//  PeriodMainScreen.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodMainScreenView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var showingAddSpendScreen = false
    
    var viewModel: PeriodMainScreenViewModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack() {
                PeriodCardView(viewModel: PeriodCardViewModel(period: viewModel.period))
                SpendListView(viewModel: SpendListViewModel(period: viewModel.period))
            }
            VStack {
                Spacer()
                CustomButton(systemName: viewModel.periodIsEnd ? "multiply" : "plus",
                             color: viewModel.periodIsEnd ? Color("AccentColor") : Color("BackgroundColor"),
                             foregroundColor: viewModel.periodIsEnd ? Color("BackgroundColor") : Color("AccentColor")) {
                    viewModel.periodIsEnd ? presentationMode.wrappedValue.dismiss() : showingAddSpendScreen.toggle()
                }
                .sheet(isPresented: $showingAddSpendScreen) {
                    AddSpendView(viewModel: AddSpendViewModel(period: viewModel.period, spend: nil))
                }
            }
        }
    }
}

