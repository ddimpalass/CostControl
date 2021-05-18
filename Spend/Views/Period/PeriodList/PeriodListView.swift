//
//  PeriodListView.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodListView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(entity: Period.entity(), sortDescriptors: [])
    var periods: FetchedResults<Period>
    
    @State var showingAddPeriodScreen = false

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                Spacer(minLength: 50)
                VStack(spacing: 16) {
                    ForEach(periods, id: \.self) { period in
                        PeriodLineView(viewModel: PeriodLineViewModel(period: period))
                    }
                }
            }
            .background(Color.init(#colorLiteral(red: 0.9500349164, green: 0.9501938224, blue: 0.9500139356, alpha: 1)))
            .ignoresSafeArea()
            VStack {
                Spacer()
                CustomButton(systemName: "plus", color: .gray, foregroundColor: .white) {
                    showingAddPeriodScreen.toggle()
                }
                .sheet(isPresented: $showingAddPeriodScreen) {
                    AddPeriod().environment(\.managedObjectContext, viewContext)
                }
            }
        }
    }
}

