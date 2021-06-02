//
//  FirstLaunchView.swift
//  Spend
//
//  Created by Apple on 02.06.2021.
//

import SwiftUI

struct FirstLaunchView: View {
    @StateObject var viewModel: FirstLaunchViewModel = FirstLaunchViewModel()
    @State var showingStartScreen = false
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "AccentColor")
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                TabView(selection: $viewModel.selection) {
                    ForEach(viewModel.headTitles.indices, id: \.self) { index in
                        Block(headTitle: viewModel.headTitles[index],
                              imageName: viewModel.imageNames[index],
                              manual: viewModel.manuals[index])
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .animation(.default)
                CustomButton(systemName: viewModel.isEnd ? "multiply" : "chevron.right",
                             color: viewModel.isEnd ? Color("AccentColor") : Color("BackgroundColor"),
                             foregroundColor: viewModel.isEnd ? Color("BackgroundColor") : Color("AccentColor")) {
                    viewModel.isEnd ? showingStartScreen.toggle() : (viewModel.selection += 1)
                }
                .fullScreenCover(isPresented: $showingStartScreen) {
                    PeriodListView()
                }
            }
        }
    }
}



struct Block: View {
    let headTitle: String
    let imageName: String
    let manual: String
    
    var body: some View {
        VStack {
            Text(headTitle)
                .font(.custom("Roboto-Light", size: 32))
                .foregroundColor(Color("AccentColor"))
                .padding()
            Image(imageName)
                .resizable()
                .scaledToFit()
            Text(manual)
                .font(.custom("Roboto-Light", size: 24))
                .foregroundColor(Color("TextColor"))
                .padding()
        }
    }
}

struct FirstLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FirstLaunchView()
            FirstLaunchView()
        }
    }
}
