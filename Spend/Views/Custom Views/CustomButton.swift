//
//  CustomButton.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct CustomButton: View {
    let systemName: String
    let color: Color
    let foregroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                Circle()
                    .foregroundColor(color)
                    .shadow(color: Color.init(.black),
                            radius: 2,
                            x: 0,
                            y: 2)
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(foregroundColor)
            }
            .frame(width: 100, height: 100)
            .padding()
        })
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(systemName: "plus", color: .gray, foregroundColor: .white, action: {})
    }
}
