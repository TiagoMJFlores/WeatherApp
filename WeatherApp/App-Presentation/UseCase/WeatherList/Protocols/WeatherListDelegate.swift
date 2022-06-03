//
//  WeatherListDelegate.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import Foundation

protocol WeatherListDelegate {
    func loadData()
    func bindView(view: WeatherViewReceiverProtocol)
}
