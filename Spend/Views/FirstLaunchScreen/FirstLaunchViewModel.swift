//
//  FirstLaunchViewModel.swift
//  Spend
//
//  Created by Apple on 02.06.2021.
//

import Foundation

protocol FirstLaunchViewModelProtocol {
    var headTitles: [String] { get }
    var imageNames: [String] { get }
    var manuals: [String] { get }
    
    var selection: Int { get }
    var isEnd: Bool { get }
}

class FirstLaunchViewModel: FirstLaunchViewModelProtocol, ObservableObject {
    @Published var isEnd: Bool = false

    var headTitles: [String] = FirstLaunchDataManager.shared.headTitles
    var imageNames: [String] = FirstLaunchDataManager.shared.imageNames
    var manuals: [String] = FirstLaunchDataManager.shared.manuals
    
    var selection: Int = 0 {
        willSet {
            isEnd = newValue == headTitles.count - 1
        }
    }
}
