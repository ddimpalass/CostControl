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
    
    func gropedByDate(spends: [Spend]) -> [String: [Spend]] {
        let sortedSpends = spends.sorted(by: {$0.date! > $1.date!})

        let groupedByDate = Dictionary(grouping: sortedSpends) { (spend: Spend) -> String in
            dateFormatterForDate.string(from: spend.date ?? Date())
        }
        return groupedByDate
    }
    
    func costByDate(spendDict: [String: [Spend]]) -> Int32 {
        guard let spendArrayInDate = spendDict[dateFormatterForDate.string(from: Date())] else { return 0 }
        let costInDate = spendArrayInDate.map({$0.cost}).reduce(0, +)
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
