//
//  SpendListView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct SpendListView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    var viewModel: SpendListViewModel
    
    var body: some View {
        VStack() {
            ForEach(viewModel.spendsDict, id: \.key) { date, spends in
                Section(header: SpendHeaderView(viewModel: SpendHeaderViewModel(date: date, spends: spends))){
                    ForEach(spends, id: \.self) { spend in
                        SpendLineView(viewModel: SpendLineViewModel(spend: spend))
                    }
                }
            }
        }
    }
}


