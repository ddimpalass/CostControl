//
//  SpendListView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct SpendListView: View {
    @StateObject var viewModel: SpendListViewModel
    
    var body: some View {
        VStack() {
            List {
                ForEach(viewModel.spendsGroupByDate, id: \.key) { date, spends in
                    Section(header: SpendHeaderView(viewModel: SpendHeaderViewModel(date: date, period: viewModel.period))){
                        ForEach(spends, id: \.self) { spend in
                            SpendLineView(viewModel: SpendLineViewModel(for: spend))
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                let deleteSpend = spends[index]
                                SpendStorageManager.shared.deleteSpend(spend: deleteSpend)
                            }
                        })
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color("BackgroundColor"))
                    .listRowInsets(EdgeInsets())
                }
            }
        }
    }
}


