//
//  DateManager.swift
//  Spend
//
//  Created by Apple on 20.05.2021.
//

import Foundation

class DateManager {
    static let shared: DateManager = DateManager()
    
    let dateFormatterForDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, E"
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
        return formatter
    }()
    
    let dateFormatterForTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    private init(){}
    
    func gropedByDate(spends: [Spend]) -> Array<(key: Date, value: Array<Spend>)> {
        let calendar = Calendar.current
        let sortedSpends = spends.sorted(by: {$0.date! > $1.date!})
        
        let groupedByDate = Dictionary(grouping: sortedSpends) { (spend: Spend) -> Date in
            calendar.startOfDay(for: spend.date ?? Date())
        }
        .sorted(by: {$0.key > $1.key})
        
        return groupedByDate
    }
    
    func costByDate(spends: [Spend], date: Date) -> Int32 {
        let calendar = Calendar.current
        let spendsByDate = spends.filter{ calendar.startOfDay(for: $0.date ?? date) == calendar.startOfDay(for: date)}
        let costInDate = spendsByDate.map{ $0.cost }.reduce(0, +)
        return costInDate
    }
    
    func dayInPeriod(start: Date, end: Date) -> Int32 {
        let calendar = Calendar.current

        let from = calendar.startOfDay(for: start)
        let to = calendar.startOfDay(for: end)

        let components = calendar.dateComponents([.day], from: from, to: to)
        
        return Int32(components.day ?? 1)
    }
}
