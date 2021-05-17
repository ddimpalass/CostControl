//
//  SpendLineView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct SpendLineView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var viewModel: SpendLineViewModel
    
    var body: some View {
        Button(action: viewModel.selectSpendButtonPressed, label: {
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
            .foregroundColor(Color.init(.darkGray))
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.init(.lightGray),
                    radius: 2,
                    x: 0,
                    y: 2)
            .padding(.horizontal)
        })
        .sheet(item: $viewModel.selectedSpend) { spend in
            AddSpend(period: spend.period!, spend: spend).environment(\.managedObjectContext, viewContext)
        }
    }
}

