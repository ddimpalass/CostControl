//
//  PeriodMainScreen.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodMainScreen: View {
    @Environment(\.managedObjectContext) var viewContext
    @State var showingAddSpendScreen = false
    
    let period: Period
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    CardOfPeriod(name: period.name ?? "Название",
                                 dayLimit: "\(period.limit / 10)",
                                 periodLimit: "\(period.limit - period.spendsArray.map({$0.cost}).reduce(0, +))")
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                        .padding(.top, geometry.safeAreaInsets.top - geometry.size.height + 250)
                    Spacer(minLength: 20)
                    ListOfSpends(spends: period.spendsArray)
                }
                .background(Color.init(#colorLiteral(red: 0.9500349164, green: 0.9501938224, blue: 0.9500139356, alpha: 1)))
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    CustomButton(systemName: "cart.badge.plus", color: .gray, foregroundColor: .white) {
                        showingAddSpendScreen.toggle()
                    }
                    .sheet(isPresented: $showingAddSpendScreen) {
                        AddSpend(period: period).environment(\.managedObjectContext, viewContext)
                    }
                }
            }
        }
    }
}

struct PeriodMainScreen_Previews: PreviewProvider {
    static var previews: some View {
        PeriodMainScreen(showingAddSpendScreen: false,
                         period: Period())
    }
}
