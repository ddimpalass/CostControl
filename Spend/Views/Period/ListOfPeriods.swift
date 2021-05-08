//
//  ListOfPeriods.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import SwiftUI

struct ListOfPeriods: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(entity: Period.entity(), sortDescriptors: [])
    var periods: FetchedResults<Period>
    
    @State var showingPeriodMainScreen = false
    @State var showingAddPeriodScreen = false

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                Spacer(minLength: 50)
                VStack(spacing: 16) {
                    ForEach(periods, id: \.self) { period in
                        LineOfPeriod(action: {showingPeriodMainScreen.toggle()}, period: period)
                            .fullScreenCover(isPresented: $showingPeriodMainScreen) {
                                PeriodMainScreen(showingPeriodMainScreen: $showingPeriodMainScreen,
                                                 period: period).environment(\.managedObjectContext, viewContext)
                            }
                    }
                }
            }
            .background(Color.init(.systemGroupedBackground))
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

//struct ListOfPeriods_Previews: PreviewProvider {
//    static var previews: some View {
//        ListOfPeriods(periods: [])
//    }
//}
