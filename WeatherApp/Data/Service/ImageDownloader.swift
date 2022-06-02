//
//  ImageDownloader.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//
import UIKit
import Security

protocol ImageDownloaderProtocol {
    func downloadImage(imageUrl: String, completion: @escaping (UIImage) -> Void)
}

final class ImageDownloader: ImageDownloaderProtocol {
    private let cachedImages = NSCache<NSString, UIImage>()
    
    func downloadImage(imageUrl: String, completion: @escaping (UIImage) -> Void) {
        
        guard let url = URL(string: imageUrl) else {
            return
        }
        if let imageFromCache = cachedImages.object(forKey: imageUrl as NSString) {
                completion(imageFromCache)
        } else {
            URLSession.shared.dataTask(with: url) {
                data, response, error in
                  if let response = data {
                      DispatchQueue.main.async {
                        if let imageToCache = UIImage(data: response) {
                            self.cachedImages.setObject(imageToCache , forKey: imageUrl as NSString)
                            completion(imageToCache)
                        }
                       
                      }
                  }
             }.resume()

        }
        

    }
}
