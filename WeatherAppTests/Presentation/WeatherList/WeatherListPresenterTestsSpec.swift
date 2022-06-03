//
//  WeatherListPresenterTestsSpec.swift
//  WeatherAppTests
//
//  Created by Tiago Flores on 03/06/2022.
//

import Foundation

import XCTest
import Quick
import Nimble
import Resolver

@testable import WeatherApp


struct WeatherListPresenterTestsSpecData {
    static let jsonFileName = "weather_data"
}

class WeatherListPresenterTestsSpec: QuickSpec  {
    
    let resolver = Resolver()
    
    override func spec() {
        
        beforeSuite {
            self.resolver.register { WeatherListInteractorStub() as WeatherListInteractorProtocol }
        }
        
        describe("Load data flow") {
            it ("should be able reload data if interactor returns valid data") {
                
                let interactor: WeatherListInteractorProtocol = self.resolver.resolve()
                let response = self.loadWeatherData()?.map(to: WeatherDataContainer.self)
                (interactor as? WeatherListInteractorStub)?.dataToReturn = response
                let presenter = WeatherListPresenter()
                let view = WeatherListViewMock()
                presenter.interactor = interactor
                presenter.bindView(view: view)
                presenter.loadData()
                expect(view.showLoadingWasCalled).to(beTrue())
                expect(view.reloadDataWasCalled).to(beTrue())
                expect(view.showErrorWasCalled).to(beFalse())
                expect(view.hideLoadingWasCalled).to(beTrue())
            }
            
            
            it ("should show error alert if interactor returns error") {
                
                let interactor: WeatherListInteractorProtocol = self.resolver.resolve()
                (interactor as? WeatherListInteractorStub)?.shouldReturnError = true
                let presenter = WeatherListPresenter()
                let view = WeatherListViewMock()
                presenter.interactor = interactor
                presenter.bindView(view: view)
                presenter.loadData()
                expect(view.showLoadingWasCalled).to(beTrue())
                expect(view.reloadDataWasCalled).to(beFalse())
                expect(view.showErrorWasCalled).to(beTrue())
                expect(view.hideLoadingWasCalled).to(beTrue())
            }
         
         
            it ("layer presentation must only present 4 items") {
                
                let interactor: WeatherListInteractorProtocol = self.resolver.resolve()
                let response = self.loadWeatherData()?.map(to: WeatherDataContainer.self)
                (interactor as? WeatherListInteractorStub)?.dataToReturn = response
                let presenter = WeatherListPresenter()
                let view = WeatherListViewMock()
                presenter.interactor = interactor
                presenter.bindView(view: view)
                presenter.loadData()
                expect(presenter.numberItems()).to(equal(4))
            }
            
        }
    }
}

extension WeatherListPresenterTestsSpec {
    
    func loadWeatherData() -> FixtureLoader? {
        let testBundle = Bundle(for: type(of: self))
        return FixtureLoader(file: WeatherListPresenterTestsSpecData.jsonFileName, in: testBundle)
    }
}

// MARK: Stubs
fileprivate class WeatherListInteractorStub: WeatherListInteractorProtocol {
    
    var dataToReturn: WeatherDataContainer?
    var shouldReturnError: Bool = false
    
    func getLisbonWeatherList(completion: @escaping (Result<WeatherDataContainer, Error>) -> ()) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "error", code: -1)))
        } else if let dataToReturn = dataToReturn {
            completion(.success(dataToReturn))
        }
    }
   
    
}

// MARK: Mocks
fileprivate class WeatherListViewMock: UIViewController, WeatherViewReceiverProtocol {
    
    var reloadDataWasCalled = false
    var showErrorWasCalled = false
    var showLoadingWasCalled = false
    var hideLoadingWasCalled = false
    
    func reloadData() {
        reloadDataWasCalled = true
    }
    
    func showErrorAlert(message: String) {
        showErrorWasCalled = true
    }
    
    func showLoading() {
        showLoadingWasCalled = true
    }
    
    func hideLoading() {
        hideLoadingWasCalled = true
    }
    
    
}

