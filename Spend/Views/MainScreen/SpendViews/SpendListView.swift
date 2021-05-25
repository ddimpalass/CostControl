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
                    Section(header: SpendHeaderView(viewModel: SpendHeaderViewModel(date: date, spends: spends))){
                        ForEach(spends, id: \.self) { spend in
                            SpendLineView(viewModel: SpendLineViewModel(spend: spend))
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                let spend = spends[index]
                                SpendStorageManager.shared.deleteSpend(spend: spend)
                            }
                        })
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .listRowInsets(EdgeInsets())
                }
            }
        }
    }
}


