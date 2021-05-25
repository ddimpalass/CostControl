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
            VStack {
                HStack(alignment: .firstTextBaseline) {
                    Text("Периоды")
                        .font(.custom("Roboto-Light", size: 32))
                    Spacer()
                    Button(action: { isEditing.toggle() }, label: {
                        Text(isEditing ? "Готово" : "Изменить")
                            .font(.custom("Roboto-Light", size: 20))
                            .foregroundColor(.black)
                    })
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
                    .background(Color.white)
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
                    .background(Color.white)
                    .listRowInsets(EdgeInsets())
                }
                .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.default)
            }
            VStack {
                Spacer()
                CustomButton(systemName: "plus", color: .gray, foregroundColor: .white) {
                    showingAddPeriodScreen.toggle()
                }
                .sheet(isPresented: $showingAddPeriodScreen) {
                    AddPeriodView(period: nil)
                }
            }
        }
    }
}
