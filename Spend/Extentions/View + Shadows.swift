//
//  View + Shadows.swift
//  Spend
//
//  Created by Apple on 31.05.2021.
//

import SwiftUI

struct Shadows: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("LightShadowColor"),
                    radius: 5,
                    x: -5,
                    y: -5)
            .shadow(color: Color("DarkShadowColor"),
                    radius: 5,
                    x: 5,
                    y: 5)
    }
}

extension View {
    func shadows() -> some View {
        self.modifier(Shadows())
    }
}
