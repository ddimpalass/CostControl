//
//  SpendLineView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct SpendLineView: View {
    @StateObject var viewModel: SpendLineViewModel
    @State var showSheet = false

    var body: some View {
        Button(action: {}, label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.name)
                        .font(.custom("Roboto-Light", size: 24))
                    Text(viewModel.time)
                        .font(.custom("Roboto-Light", size: 14))
                }
                Spacer()
                Text(viewModel.cost).baselineOffset(-10)
                    .font(.custom("DIN Condensed Bold", size: 36))
            }
            .padding()
            .foregroundColor(Color("DarkTextColor"))
            .background(LinearGradient.gradientWithMainColor)
            .cornerRadius(8)
        })
        .contextMenu {
                Button {
                    viewModel.selectSpendButtonPressed()
                    showSheet.toggle()
                } label: {
                    Label("Изменить", systemImage: "ellipsis.circle")
                }
            }
        .sheet(isPresented: $showSheet) {
            AddSpendView(period: nil, spend: viewModel.selectedSpend)
        }
    }
}

