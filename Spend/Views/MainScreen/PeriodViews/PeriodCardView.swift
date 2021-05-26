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
    
    let gradient = Gradient(colors: [Color("MainColor"), Color("MainColorHelper")])
    
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
                            .frame(height: 30)
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
                    .frame(height: 30)
                    .padding()
                }
                .frame(height: 60)
                .padding()
                Text(viewModel.name)
                    .font(.custom("Roboto-Light", size: 32))
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text(viewModel.dayLimit)
                        .font(.custom("DIN Condensed Bold", size: 64))
                        .padding(.top, 16)
                    Text("/" + viewModel.periodLimit)
                        .font(.custom("Roboto-Light", size: 24))
                }
            }
            Spacer()
        }
        .foregroundColor(Color("DarkTextColor"))
        .padding(.vertical, 20)
        .background(LinearGradient(gradient: gradient,
                                   startPoint: .top,
                                   endPoint: .bottom)
        )
        .cornerRadius(39, corners: .bottomLeft)
        .cornerRadius(39, corners: .bottomRight)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


