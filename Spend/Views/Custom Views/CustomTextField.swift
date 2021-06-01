//
//  CustomTextField.swift
//  Spend
//
//  Created by Дмитрий on 09.05.2021.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(.custom("Roboto-Light", size: 24))
            .padding()
            .background(LinearGradient.gradientWithMainColor)
            .foregroundColor(Color("TextColor"))
            .cornerRadius(8)
            .shadows()
            .padding(8)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeholder: "Введите")
    }
}
