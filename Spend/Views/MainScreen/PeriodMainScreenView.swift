//
//  PeriodMainScreen.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodMainScreenView: View {
    @State var showingAddSpendScreen = false
    
    var viewModel: PeriodMainScreenViewModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack(spacing: 0) {
                PeriodCardView(viewModel: PeriodCardViewModel(period: viewModel.period))
                    .frame(height: 270)
                SpendListView(viewModel: SpendListViewModel(period: viewModel.period))
            }
            .ignoresSafeArea()
            VStack {
                Spacer()
                CustomButton(systemName: "plus",
                             color: Color("DarkTextColor"),
                             foregroundColor: Color("BackgroundColor")) {
                    showingAddSpendScreen.toggle()
                }
                .sheet(isPresented: $showingAddSpendScreen) {
                    AddSpendView(viewModel: AddSpendViewModel(period: viewModel.period, spend: nil))
                }
            }
        }
    }
}

