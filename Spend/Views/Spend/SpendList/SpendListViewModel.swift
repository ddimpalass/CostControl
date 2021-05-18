//
//  SpendListViewModel.swift
//  Spend
//
//  Created by Apple on 14.05.2021.
//

import Foundation

protocol SpendListViewModelProtocol {
    init(spendsDict: Array<(key: String, value: Array<Spend>)>)
}

class SpendListViewModel: SpendListViewModelProtocol, ObservableObject {
    let spendsDict: Array<(key: String, value: Array<Spend>)>
    
    required init(spendsDict: Array<(key: String, value: Array<Spend>)>) {
        self.spendsDict = spendsDict
    }
}

