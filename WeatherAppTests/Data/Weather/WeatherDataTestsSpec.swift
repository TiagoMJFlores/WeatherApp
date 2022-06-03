//
//  WeatherDataTestsSpec.swift
//  WeatherAppTests
//
//  Created by Tiago Flores on 03/06/2022.
//


import XCTest
import Quick
import Nimble

@testable import WeatherApp

struct WeatherDataTestsData {
    static let jsonFileName = "weather_data"
    static let numberOfExpectedElements = 40
}

class WeatherDataTestsSpec: QuickSpec {

    override func spec() {
        
        describe("SportData Model decoding") {
            it ("should be able to init WeatherDataContainer correctly with json data from api response") { [self] in
                let response = self.loadWeatherData()?.map(to: WeatherDataContainer.self)
                self.validateData(response: response)
            }
        }
    }
    
    private func validateData(response: WeatherDataContainer?) {
        expect(response).toNot(beNil())
        expect(response?.weatherList.count).to(equal(WeatherDataTestsData.numberOfExpectedElements))
        let weatherListfirstElement = response?.weatherList.first
        expect(weatherListfirstElement?.dt).toNot(beNil())
        expect(weatherListfirstElement?.weatherImages).toNot(beNil())
        
        let weatheImagesfirstElement = weatherListfirstElement?.weatherImages.first
        expect(weatheImagesfirstElement?.icon).toNot(beNil())
    }

}

extension WeatherDataTestsSpec {
    
    func loadWeatherData() -> FixtureLoader? {
        let testBundle = Bundle(for: type(of: self))
        return FixtureLoader(file: WeatherListPresenterTestsSpecData.jsonFileName, in: testBundle)
    }
}
