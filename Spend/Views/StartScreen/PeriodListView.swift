//
//  PeriodListView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodListView: View {
    @StateObject private var viewModel = PeriodListViewModel()
    @State var showingAddPeriodScreen = false
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(named: "BackgroundColor")
        UITableView.appearance().backgroundColor = UIColor(named: "BackgroundColor")
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                HStack() {
                    Spacer()
                    Text("Периоды")
                        .font(.custom("Roboto-Light", size: 32))
                        .foregroundColor(Color("AccentColor"))
                    Spacer()
                }
                .padding()
                List {
                    Section(header: PeriodHeaderView(viewModel: PeriodHeaderViewModel(there: .active))){
                        ForEach(viewModel.activePeriods, id: \.self) { period in
                            PeriodLineView(viewModel: PeriodLineViewModel(period: period))
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                let period = viewModel.activePeriods[index]
                                PeriodStorageManager.shared.deletePeriod(period: period)
                            }
                        })
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color("BackgroundColor"))
                    .listRowInsets(EdgeInsets())
                    Section(header: PeriodHeaderView(viewModel: PeriodHeaderViewModel(there: .completed))){
                        ForEach(viewModel.completedPeriods, id: \.self) { period in
                            PeriodLineView(viewModel: PeriodLineViewModel(period: period))
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                let period = viewModel.completedPeriods[index]
                                PeriodStorageManager.shared.deletePeriod(period: period)
                            }
                        })
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color("BackgroundColor"))
                    .listRowInsets(EdgeInsets())
                }
            }
            VStack {
                Spacer()
                CustomButton(systemName: "plus",
                             color: Color("BackgroundColor"),
                             foregroundColor: Color("AccentColor")) {
                    showingAddPeriodScreen.toggle()
                }
                .fullScreenCover(isPresented: $showingAddPeriodScreen) {
                    AddPeriodView(viewModel: AddPeriodViewModel(period: nil))
                }
            }
        }
    }
}

