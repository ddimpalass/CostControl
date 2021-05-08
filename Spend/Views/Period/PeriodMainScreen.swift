//
//  PeriodMainScreen.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodMainScreen: View {
    @Binding var showingPeriodMainScreen: Bool
    @State var showingAddSpendScreen = false
    
    let period: Period
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    CardOfPeriod(showingPeriodMainScreen: $showingPeriodMainScreen,
                                 name: period.name ?? "Название",
                                 dayLimit: "\(period.limit / 10)",
                                 periodLimit: "\(period.limit)")
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                        .padding(.top, geometry.safeAreaInsets.top - geometry.size.height + 250)
                    ListOfSpends(spends: [])
                }
                .background(Color.init(.systemGroupedBackground))
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    CustomButton(systemName: "cart.badge.plus", color: .gray, foregroundColor: .white) {
                        showingAddSpendScreen.toggle()
                    }
                }
            }
        }
    }
}

struct PeriodMainScreen_Previews: PreviewProvider {
    static var previews: some View {
        PeriodMainScreen(showingPeriodMainScreen: .constant(false), 
                         showingAddSpendScreen: false,
                         period: Period())
    }
}
