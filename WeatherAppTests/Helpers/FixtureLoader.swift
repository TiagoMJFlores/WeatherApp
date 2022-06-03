//
//  FixtureLoader.swift
//  WeatherAppTests
//
//  Created by Tiago Flores on 03/06/2022.
//

import Foundation


struct FixtureLoader {
    
    let data: Data
    let json: String
    
    init?(file: String, withExtension fileExt: String = "json", in bundle:Bundle = Bundle.main) {
        guard let path = bundle.path(forResource: file, ofType: fileExt) else {
            return nil
        }
        let pathURL = URL(fileURLWithPath: path)
        do {
            data = try Data(contentsOf: pathURL, options: .dataReadingMapped)
            if let decoded = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? {
                json = decoded
            } else {
                return nil
            }
        } catch let error {
            print(error)
            return nil
        }
    }
}

extension FixtureLoader {
    
    func map<T: Decodable>(to type: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch let error {
            print(error) // json data log for tests
            return nil
        }
    }
    
    func getJsonData() -> Data {
        return data
    }
}

