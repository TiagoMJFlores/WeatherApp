//
//  WeatherList+Injection.swift
//  WeatherApp
//
//  Created by Tiago Flores on 02/06/2022.
//

import Foundation

import Resolver

extension Resolver {
    
    public static func registerWeatherListModule() {
        register {
            WeatherAPIClient() as  WeatherAPIClientProtocol
        }
        register {
            WeatherListInteractor() as WeatherListInteractorProtocol
        }
        register {
            WeatherListPresenter() as WeatherListPresenterProtocol
        }
        
        register {
            ImageDownloader() as ImageDownloaderProtocol
        }
     
    }
}
