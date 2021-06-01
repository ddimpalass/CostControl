//
//  SpendHeaderView.swift
//  Spend
//
//  Created by Apple on 17.05.2021.
//

import SwiftUI

struct SpendHeaderView: View {
    @StateObject var viewModel: SpendHeaderViewModel
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(viewModel.dateString)
                .font(.custom("Roboto-Light", size: 18))
            Spacer()
            Text(viewModel.costSum)
                .font(.custom("Roboto-Light", size: 20))
        }
        .foregroundColor(Color("TextColor"))
        .padding(.horizontal)
        .padding(.bottom, -8)
    }
}

