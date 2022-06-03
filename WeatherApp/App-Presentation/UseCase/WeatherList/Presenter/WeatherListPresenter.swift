//
//  WeatherListPresenter.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import Resolver

typealias WeatherListPresenterProtocol = WeatherListDelegate & WeatherListDataSource


final class WeatherListPresenter {
    
    weak var view: WeatherViewReceiver?
    
    @Injected var interactor: WeatherListInteractorProtocol
    @Injected var imageDownloader: ImageDownloaderProtocol

    private var weatherViewData: [WeatherDayViewModel] = []
    
    init() {
    }
    
}


extension WeatherListPresenter: WeatherListDelegate {
    

    fileprivate enum Constants {
        static let limitDays = 4
    }
    
    func bindView(view: WeatherViewReceiver) {
        self.view = view
    }


    func loadData() {
        getData()
    }
    
    
    private func getData() {
        
        view?.showLoading()
        interactor.getLisbonWeatherList {  [weak self] result in
            guard let safeSelf = self else {
                return
            }
            safeSelf.view?.hideLoading()
            switch result {
            case .success(let weatherDataContainer):
               
                safeSelf.weatherViewData = Array(safeSelf.mapModelDataToViewData(from: weatherDataContainer.weatherList).prefix(Constants.limitDays))
                safeSelf.weatherViewData.sort(by: { $0.day.compare($1.day) == .orderedAscending })
                safeSelf.view?.reloadData()
                 
            case .failure(let error):
                safeSelf.view?.showErrorAlert(message: error.localizedDescription)
                break
            }
        }
    }

       
    private func sortWeatherByDay(from weatherList: [WeatherList]) ->  [String: [WeatherList]]  {
        var weatherData: [String: [WeatherList]] =  [String: [WeatherList]]()
        
        for item in weatherList.sorted(by: { $0.dt < $1.dt}) {
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
