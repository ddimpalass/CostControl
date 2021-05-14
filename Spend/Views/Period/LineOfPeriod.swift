//
//  LineOfPeriod.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct LineOfPeriod: View {
    let action: () -> Void
    let period: Period
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                VStack(alignment: .leading){
                    Text(period.name ?? "Название")
                        .font(.custom("Roboto-Light", size: 24))
                    HStack(alignment: .lastTextBaseline) {
                        Text("\(period.limit - period.spendsArray.map({$0.cost}).reduce(0, +))")
                            .font(.custom("DIN Condensed Bold", size: 36))
                        Text("/\(period.limit)")
                            .font(.custom("Roboto-Light", size: 24))
                    }
                    .padding(.top, 4)
                }
                Spacer()
                Image(systemName: "chevron.right.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
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
    }
}


struct LineOfPeriod_Previews: PreviewProvider {
    static var previews: some View {
        LineOfPeriod(action: {}, period: Period())
    }
}
