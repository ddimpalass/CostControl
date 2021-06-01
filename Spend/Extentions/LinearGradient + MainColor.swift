//
//  LinearGradient + MainColor.swift
//  Spend
//
//  Created by Apple on 26.05.2021.
//

import SwiftUI

extension LinearGradient {
    static var gradientWithMainColor: LinearGradient {
        let gradient = Gradient(colors: [Color("MainColorForGradient"), Color("MainColor")])
        return LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
