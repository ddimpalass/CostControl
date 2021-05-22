//
//  PeriodMainScreen.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodMainScreenView: View {
    @State var showingAddSpendScreen = false
    
    @ObservedObject var viewModel: PeriodMainScreenViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                PeriodCardView(viewModel: PeriodCardViewModel(period: viewModel.period))
                    .frame(height: 270)
                SpendListView(viewModel: SpendListViewModel(period: viewModel.period))
            }
            .ignoresSafeArea()
            VStack {
                Spacer()
                CustomButton(systemName: "cart.badge.plus", color: .gray, foregroundColor: .white) {
                    showingAddSpendScreen.toggle()
                }
                .sheet(isPresented: $showingAddSpendScreen) {
                    AddSpendView(period: viewModel.period, spend: nil)
                }
            }
        }
    }
}

