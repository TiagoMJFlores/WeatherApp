//
//  WeatherDayPresenterProtocol.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//


import UIKit

protocol WeatherDayPresenterProtocol: WeatherCollectionDataSource {
    var weatherData: WeatherDayViewModel { get}
    func downloadImage(indexPath: IndexPath, completion: @escaping (UIImage) -> Void)
}

final class WeatherDayPresenter: WeatherDayPresenterProtocol {
    
    private(set) var imageDownloader: ImageDownloaderProtocol
    private(set) var weatherData: WeatherDayViewModel
    
    init(weatherData: WeatherDayViewModel, imageDownloader: ImageDownloaderProtocol) {
        self.weatherData = weatherData
        self.imageDownloader = imageDownloader
    }
    
}

extension WeatherDayPresenter: WeatherCollectionDataSource  {
    
    func weatherDataStr(indexPath: IndexPath) -> String {
        let element = item(at: indexPath)
        let result =  "\(Translations.temperature): \(element.main.temp), \(Translations.time): \(element.timeStr)"
        return result
    }
    
    private func imageUrl(for indexPath: IndexPath) -> String? {
        let element = item(at: indexPath)
        guard let weatherItem = element.weatherImages.first else {
            return nil
        }
        let imageUrl =  "\(NetworkConfigs.weatherAPIImageRepoUrl)\(weatherItem.icon)@2x.png"
        return imageUrl
    }
    
   
    func numberItems() -> Int {
        return weatherData.weatherList.count
    }
    
    func item(at indexPath: IndexPath) -> WeatherList {
        let element = weatherData.weatherList[indexPath.row]
        return element
    }
    
    
    func downloadImage(indexPath: IndexPath, completion: @escaping (UIImage) -> Void) {
        if let imageUrl = imageUrl(for: indexPath) {
            imageDownloader.downloadImage(imageUrl: imageUrl, completion: completion)
        }
    }
    
    
}
