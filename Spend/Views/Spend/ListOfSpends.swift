//
//  ListOfSpends.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct ListOfSpends: View {
    @Environment(\.managedObjectContext) var viewContext
    
    let spendsDict: Dictionary<String, [Spend]>
    
    @State private var selectedSpend: Spend? = nil

    var body: some View {
        VStack() {
            ForEach(spendsDict.sorted(by: {$0.key > $1.key}), id: \.key) { date, spends in
                Section(header: Header(date: date, costSum: "\(spends.map({$0.cost}).reduce(0, +))")){
                    ForEach(spends, id: \.self) { spend in
                        LineOfSpend(action: { selectedSpend = spend },
                                    name: spend.name ?? "Название",
                                    time: dateFormatterForTime.string(from: spend.date ?? Date()),
                                    cost: "\(spend.cost)")
                            .sheet(item: $selectedSpend) { spend in
                                AddSpend(period: spend.period!, spend: spend).environment(\.managedObjectContext, viewContext)
                            }
                    }
                }
                
            }
        }
    }
}

struct Header: View {
    let date: String
    let costSum: String

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(date)
                .font(.custom("Roboto-Light", size: 20))
            Spacer()
            Text(costSum)
                .font(.custom("Roboto-Light", size: 24))
        }
        .foregroundColor(Color.init(.darkGray))
        .padding(.horizontal)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(date: "6 мая 2021", costSum: "500")
    }
}

private let dateFormatterForTime: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
}()
