//
//  AppDelegate+Injection.swift
//  WeatherApp
//
//  Created by Tiago Flores on 02/06/2022.
//

import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerWeatherListModule()
    }
}
