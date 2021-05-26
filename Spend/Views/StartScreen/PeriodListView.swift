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
    @State var isEditing = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                HStack(alignment: .firstTextBaseline) {
                    Text("Периоды")
                        .font(.custom("Roboto-Light", size: 32))
                    Spacer()
                    Button(action: { isEditing.toggle() }, label: {
                        Text(isEditing ? "Готово" : "Изменить")
                            .font(.custom("Roboto-Light", size: 20))
                    })
                }
                .foregroundColor(Color("DarkTextColor"))
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
                .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.default)
            }
            VStack {
                Spacer()
                CustomButton(systemName: "plus",
                             color: Color("DarkTextColor"),
                             foregroundColor: Color("BackgroundColor")) {
                    showingAddPeriodScreen.toggle()
                }
                .sheet(isPresented: $showingAddPeriodScreen) {
                    AddPeriodView(period: nil)
                }
            }
        }
    }
}

