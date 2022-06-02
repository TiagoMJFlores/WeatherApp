//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Tiago Flores on 02/06/2022.
//

import Foundation
import Alamofire

protocol WeatherAPIClientProtocol {
    func getWeatherList(cityName: String, completion: @escaping (Result<WeatherDataContainer, Error>) -> ())
}

final class WeatherAPIClient {
    
}

extension WeatherAPIClient: WeatherAPIClientProtocol {
    
    func getWeatherList(cityName: String, completion: @escaping (Result<WeatherDataContainer, Error>) -> ()) {
        let endpoint = WeatherEndPoint.forecast(city: "Lisbon")
        AF.request(endpoint.path, parameters: endpoint.queryParams)
            .validate()
            .responseDecodable(of: WeatherDataContainer.self) { (response) in
                guard let data = response.value else {
                    
                    completion(.failure(NSError(domain: "error", code: -1) as Error))
                    return
                    
                }
                
                completion(.success(data))
            }
    }
}
