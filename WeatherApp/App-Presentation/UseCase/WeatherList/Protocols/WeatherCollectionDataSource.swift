//
//  WeatherCollectionDataSource.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import Foundation

protocol WeatherCollectionDataSource {
    func weatherDataStr(indexPath: IndexPath) -> String
    func numberItems() -> Int
    func item(at indexPath: IndexPath) -> WeatherList
}
