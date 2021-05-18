//
//  PeriodMainScreen.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct PeriodMainScreenView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State var showingAddSpendScreen = false
    
    var viewModel: PeriodMainScreenViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    PeriodCardView(viewModel: PeriodCardViewModel(period: viewModel.period))
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                        .padding(.top, geometry.safeAreaInsets.top - geometry.size.height + 250)
                    Spacer(minLength: 20)
                    SpendListView(viewModel: SpendListViewModel(spendsDict: viewModel.spendsDict))
                }
                .background(Color.init(#colorLiteral(red: 0.9500349164, green: 0.9501938224, blue: 0.9500139356, alpha: 1)))
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    CustomButton(systemName: "cart.badge.plus", color: .gray, foregroundColor: .white) {
                        showingAddSpendScreen.toggle()
                    }
                    .sheet(isPresented: $showingAddSpendScreen) {
                        AddSpend(period: viewModel.period, spend: nil).environment(\.managedObjectContext, viewContext)
                    }
                }
            }
        }
    }
}
