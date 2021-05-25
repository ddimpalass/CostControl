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
            Text(viewModel.date)
                .font(.custom("Roboto-Light", size: 20))
            Spacer()
            Text(viewModel.costSum)
                .font(.custom("Roboto-Light", size: 24))
        }
        .foregroundColor(Color.init(.darkGray))
        .padding(.horizontal)
    }
}

