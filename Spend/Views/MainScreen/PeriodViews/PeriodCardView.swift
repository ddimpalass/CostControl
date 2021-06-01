//
//  PeriodCardView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodCardView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @StateObject var viewModel: PeriodCardViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() } ) {
                    Image.init(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding()
                        .background(LinearGradient.gradientWithMainColor)
                        .cornerRadius(4)
                        .shadows()
                }
                Spacer()
                VStack(spacing: 8) {
                    HStack {
                        Spacer()
                        Text(viewModel.name)
                            .font(.custom("Roboto-Light", size: 32))
                            .foregroundColor(Color("AccentColor"))
                            .lineLimit(1)
                    }
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Spacer()
                        Text(viewModel.dayNow)
                            .font(.custom("DIN Condensed Bold", size: 32))
                            .lineLimit(1)
                            .padding(.bottom, -8)
                        Text(viewModel.dayCount)
                            .font(.custom("Roboto-Light", size: 16))
                            .lineLimit(1)
                    }
                }
            }
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Spacer()
                Text(viewModel.dayLimit)
                    .font(.custom("DIN Condensed Bold", size: 64))
                Text("/" + viewModel.periodLimit)
                    .font(.custom("Roboto-Light", size: 24))
                Spacer()
            }
            .padding()
            .padding(.bottom, -16)
            .background(LinearGradient.gradientWithMainColor)
            .cornerRadius(8)
            .shadows()
        }
        .padding()
        .foregroundColor(Color("TextColor"))
        .background(LinearGradient.gradientWithMainColor)
        .cornerRadius(16)
        .shadows()
        .padding()
    }
}


