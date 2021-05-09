//
//  LineOfSpend.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct LineOfSpend: View {
    let action: () -> Void
    let name: String
    let time: String
    let cost: String
    
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.custom("Roboto-Light", size: 24))
                    Text(time)
                        .font(.custom("Roboto-Light", size: 14))
                }
                Spacer()
                Text(cost).baselineOffset(-10)
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
    }
}

struct LineOfSpend_Previews: PreviewProvider {
    static var previews: some View {
        LineOfSpend(action: {},
                    name: "Купил что-то",
                    time: "11:32",
                    cost: "430")
    }
}
