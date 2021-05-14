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
                    CardOfPeriod(name: period.name ?? "",
                        dayNow: "\(dayInPeriod(start: period.startDate!, end: Date()) + 1)",
                        dayCount: "\(dayInPeriod(start: period.startDate!, end: period.endDate!))",
                        dayLimit: "\(period.limit/(dayInPeriod(start: period.startDate!, end: period.endDate!)) - costByDate(spendDict: gropedByDate(spends: period.spendsArray)))",
                        periodLimit: "\(period.limit/(dayInPeriod(start: period.startDate!, end: period.endDate!)))")
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                        .padding(.top, geometry.safeAreaInsets.top - geometry.size.height + 250)
                    Spacer(minLength: 20)
                    ListOfSpends(spendsDict: gropedByDate(spends: period.spendsArray))
                }
                .background(Color.init(#colorLiteral(red: 0.9500349164, green: 0.9501938224, blue: 0.9500139356, alpha: 1)))
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    CustomButton(systemName: "cart.badge.plus", color: .gray, foregroundColor: .white) {
                        showingAddSpendScreen.toggle()
                    }
                    .sheet(isPresented: $showingAddSpendScreen) {
                        AddSpend(period: period, spend: nil).environment(\.managedObjectContext, viewContext)
                    }
                }
            }
        }
    }
}

//struct PeriodMainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PeriodMainScreen(showingAddSpendScreen: false,
//                         period: Period())
//    }
//}

private func dayInPeriod(start: Date, end: Date) -> Int32 {
    let calendar = Calendar.current

    let from = calendar.startOfDay(for: start)
    let to = calendar.startOfDay(for: end)

    let components = calendar.dateComponents([.day], from: from, to: to)
    
    return Int32(components.day ?? 1)
}

private func costByDate(spendDict: [String: [Spend]]) -> Int32 {
    guard let spendArrayInDate = spendDict[dateFormatterForDate.string(from: Date())] else { return 0 }
    let costInDate = spendArrayInDate.map({$0.cost}).reduce(0, +)
    return costInDate
}

private func gropedByDate(spends: [Spend]) -> [String: [Spend]] {
    let sortedSpends = spends.sorted(by: {$0.date! > $1.date!})
    
    let groupedByDate = Dictionary(grouping: sortedSpends) { (spend: Spend) -> String in
        dateFormatterForDate.string(from: spend.date ?? Date())
    }
    return groupedByDate
}

private let dateFormatterForDate: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM, E"
    formatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
    return formatter
}()
