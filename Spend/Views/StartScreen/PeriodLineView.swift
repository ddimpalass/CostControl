//
//  PeriodLineView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodLineView: View {
    @StateObject var viewModel: PeriodLineViewModel
    @State var isPressed: Bool = false
    
    var body: some View {
        Button(action: {
            isPressed.toggle()
            viewModel.activeSheet = .open
            viewModel.selectPeriodButtonPressed()
        }){
            HStack {
                VStack(alignment: .leading){
                    Text(viewModel.name)
                        .font(.custom("Roboto-Light", size: 24))
                        .lineLimit(2)
                    HStack(alignment: .lastTextBaseline, spacing: 0) {
                        Text(viewModel.balance)
                            .font(.custom("DIN Condensed Bold", size: 36))
                            .lineLimit(1)
                        Text(viewModel.limit)
                            .font(.custom("Roboto-Light", size: 20))
                            .lineLimit(1)
                    }
                    .padding(.top, 4)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(LinearGradient.gradientWithMainColor)
                    .cornerRadius(4)
                    .shadows()
            }
            .padding()
            .foregroundColor(Color("TextColor"))
            .background(LinearGradient.gradientWithMainColor)
            .cornerRadius(8)
            .shadows()
            .padding(4)
        }
        .contextMenu {
            Button {
                viewModel.activeSheet = .update
                viewModel.selectPeriodButtonPressed()
            } label: {
                Label("Изменить", systemImage: "ellipsis.circle")
            }
        }
        .fullScreenCover(isPresented: $viewModel.showSheet) {
            if viewModel.activeSheet == .open {
                PeriodMainScreenView(viewModel: PeriodMainScreenViewModel(period: viewModel.selectedPeriod!))
            } else {
                AddPeriodView(viewModel: AddPeriodViewModel(period: viewModel.selectedPeriod))
            }
        }
    }
}

