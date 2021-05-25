//
//  PeriodHeaderView.swift
//  Spend
//
//  Created by Apple on 24.05.2021.
//

import SwiftUI

struct PeriodHeaderView: View {
    @StateObject var viewModel: PeriodHeaderViewModel

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(viewModel.status)
                .font(.custom("Roboto-Light", size: 20))
            Spacer()
            Text(viewModel.count)
                .font(.custom("Roboto-Light", size: 24))
        }
        .foregroundColor(Color.init(.darkGray))
        .padding(.horizontal)
    }
}

