//
//  WeatherListPresenter.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import Foundation

typealias WeatherListPresenterProtocol = WeatherListDelegate & WeatherListDataSource


final class WeatherListPresenter {
    
    weak var view: WeatherViewReceiver?
    var interactor = WeatherListInteractor()
    private let imageDownloader = ImageDownloader()

    private var weatherViewData: [WeatherDayViewModel] = []
    
    init() {
    }
    
}


extension WeatherListPresenter: WeatherListDelegate {
    

    func bindView(view: WeatherViewReceiver) {
        self.view = view
    }


    func loadData() {
        getData()
    }
    
    
    private func getData() {
        
        interactor.getLisbonWeatherList { result in
            switch result {
            case .success(let weatherDataContainer):
               
                self.weatherViewData = self.mapModelDataToViewData(from: weatherDataContainer.weatherList)
                  self.weatherViewData.sort(by: { $0.day.compare($1.day) == .orderedAscending })
                  self.view?.reloadData()
                 
            case .failure(let error):
                break
            }
        }
    }

       
    private func sortWeatherByDay(from weatherList: [WeatherList]) ->  [String: [WeatherList]]  {
        var weatherData: [String: [WeatherList]] =  [String: [WeatherList]]()
        for item in weatherList.sorted(by: { $0.dt > $1.dt}) {
            let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
  
            let dayStr: String = WeatherDateFormatter.date(toString: date)
            var elementsInDay = weatherData[dayStr]
            if elementsInDay == nil {
                elementsInDay = []
            }
            elementsInDay?.append(item)
            weatherData[dayStr] = elementsInDay
        }
        return weatherData
    }
  
    private func mapModelDataToViewData(from weatherList: [WeatherList]) -> [WeatherDayViewModel]  {
        let weatherData: [String: [WeatherList]] = sortWeatherByDay(from: weatherList)
        let weatherViewData: [WeatherDayViewModel] = weatherData.keys.map { key in
            let elementsInDay = weatherData[key]
            let weatherViewData = WeatherDayViewModel(day: key, weatherList: elementsInDay ?? [])
            
            return weatherViewData
        }
        return weatherViewData
    }
    
}



extension WeatherListPresenter: WeatherListDataSource {
    
    func item(at indexPath: IndexPath) -> WeatherDayPresenterProtocol {
        let element = weatherViewData[indexPath.row]
        return WeatherDayPresenter(weatherData: element, imageDownloader: imageDownloader)
    }
    
    func numberItems() -> Int {
        let result = weatherViewData.count
        return result
    }
    
}
