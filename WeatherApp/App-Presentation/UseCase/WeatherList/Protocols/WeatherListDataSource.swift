//
//  WeatherListDataSource.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import Foundation

protocol WeatherListDataSource {
    func numberItems() -> Int
    func item(at indexPath: IndexPath)  -> WeatherDayPresenterProtocol
}
