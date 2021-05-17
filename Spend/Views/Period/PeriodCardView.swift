//
//  PeriodCardView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodCardView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    let name: String
    let dayNow: String
    let dayCount: String
    let dayLimit: String
    let periodLimit: String
    
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
                            .frame(width: 30, height: 30)
                            .padding()
                    }
                    Spacer()
                    Circle()
                    Spacer()
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("\(dayNow)")
                            .font(.custom("DIN Condensed Bold", size: 32))
                            .padding(.top, 8)
                        Text("/\(dayCount)")
                            .font(.custom("Roboto-Light", size: 16))
                    }
                    .frame(width: 30, height: 30)
                    .padding()
                }
                .frame(height: 60)
                .padding()
                Text(name + " ")
                    .font(.custom("Roboto-Light", size: 32))
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("\(dayLimit)")
                        .font(.custom("DIN Condensed Bold", size: 64))
                        .padding(.top, 16)
                    Text("/\(periodLimit)")
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

struct CardOfPeriod_Previews: PreviewProvider {
    static var previews: some View {
        PeriodCardView(name: "Псков",dayNow: "1", dayCount: "3", dayLimit: "5000", periodLimit: "40000")
    }
}
