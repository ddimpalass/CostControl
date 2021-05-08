//
//  ListOfSpends.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct ListOfSpends: View {
    let spends: [Spend]
    
    var body: some View {
        VStack() {
            ForEach(spends) { spend in
                LineOfSpend(name: spend.name ?? "Empty",
                            time: dateFormatter.string(from: spend.date ?? Date()),
                            cost: "\(spend.cost)")
            }
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
}()
