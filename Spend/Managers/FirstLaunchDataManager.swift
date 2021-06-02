//
//  FirstLaunchDataManager.swift
//  Spend
//
//  Created by Apple on 02.06.2021.
//

import Foundation

class FirstLaunchDataManager {
    static var shared: FirstLaunchDataManager = FirstLaunchDataManager()
    
    let headTitles: [String] = ["Добавляй", "Изменяй", "Удаляй"]
    let imageNames: [String] = ["manualAdd", "manualUpdate", "manualDelete"]
    let manuals: [String] = ["Для добавления периода/траты нажми на кнопку +",
                             "Для изменения периода/траты нажми и удерживай период/трату которую хочешь изменить",
                             "Для удаления периода/траты смахни в бок период/трату которую хочешь удалить"]
    private init(){}
}
