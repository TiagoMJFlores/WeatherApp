//
//  WeatherViewReceiver.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import Foundation
import UIKit

protocol WeatherViewReceiverProtocol where Self: UIViewController {
    func reloadData()
    func showErrorAlert(message: String)
    func showLoading()
    func hideLoading()
}
