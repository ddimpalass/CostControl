//
//  PeriodCardView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodCardView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var viewModel: PeriodCardViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image.init(systemName: "chevron.backward.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 30)
                            .padding()
                    }
                    Spacer()
                    Circle()
                    Spacer()
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text(viewModel.dayNow)
                            .font(.custom("DIN Condensed Bold", size: 32))
                            .padding(.top, 8)
                        Text(viewModel.dayCount)
                            .font(.custom("Roboto-Light", size: 16))
                    }
                    .frame(width: 40, height: 30)
                    .padding()
                }
                .frame(height: 60)
                .padding()
                Text(viewModel.name)
                    .font(.custom("Roboto-Light", size: 32))
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    // DayLimit!!
                    Text(viewModel.periodLimit)
                        .font(.custom("DIN Condensed Bold", size: 64))
                        .padding(.top, 16)
                    Text(viewModel.periodLimit)
                        .font(.custom("Roboto-Light", size: 24))
                }
            }
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.vertical, 20)
        .background(Color.gray)
        .cornerRadius(39)
    }
}


