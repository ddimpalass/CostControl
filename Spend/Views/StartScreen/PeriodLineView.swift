//
//  PeriodLineView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodLineView: View {
    @StateObject var viewModel: PeriodLineViewModel
    
    var body: some View {
        Button(action: {
            viewModel.activeSheet = .open
            viewModel.selectPeriodButtonPressed()
        }){
            HStack {
                VStack(alignment: .leading){
                    Text(viewModel.name)
                        .font(.custom("Roboto-Light", size: 24))
                    HStack(alignment: .lastTextBaseline) {
                        Text(viewModel.balance)
                            .font(.custom("DIN Condensed Bold", size: 36))
                        Text(viewModel.limit)
                            .font(.custom("Roboto-Light", size: 24))
                    }
                    .padding(.top, 4)
                }
                Spacer()
                Image(systemName: "chevron.right.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            .padding()
            .foregroundColor(Color.init(.darkGray))
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.init(.lightGray),
                    radius: 2,
                    x: 0,
                    y: 2)
        }
        .contextMenu {
            Button {
                viewModel.activeSheet = .update
                viewModel.selectPeriodButtonPressed()
            } label: {
                Label("Изменить", systemImage: "globe")
            }
        }
        .fullScreenCover(isPresented: $viewModel.showSheet) {
            if viewModel.activeSheet == .open {
                PeriodMainScreenView(viewModel: PeriodMainScreenViewModel(period: viewModel.selectedPeriod!))
            } else {
                AddPeriodView(period: viewModel.selectedPeriod)
            }
            
        }
    }
}

