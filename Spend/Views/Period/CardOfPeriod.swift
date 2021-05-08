//
//  CardOfPeriod.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct CardOfPeriod: View {
    @Binding var showingPeriodMainScreen: Bool
    
    let name: String
    let dayLimit: String
    let periodLimit: String
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                HStack {
                    Button(action: {showingPeriodMainScreen.toggle()}) {
                        Image.init(systemName: "chevron.backward.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding()
                    }
                    Spacer()
                    Circle()
                    Spacer()
                    Button(action: {}) {
                        Image.init(systemName: "arrow.up.arrow.down.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding()
                    }
                }
                .frame(height: 60)
                .padding()
                Text(name)
                    .font(.custom("Roboto-Light", size: 24))
                HStack(alignment: .firstTextBaseline) {
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
        CardOfPeriod(showingPeriodMainScreen: .constant(false), name: "Псков", dayLimit: "5000", periodLimit: "40000")
    }
}
