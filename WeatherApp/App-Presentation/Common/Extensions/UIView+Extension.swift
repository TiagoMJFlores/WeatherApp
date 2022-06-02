//
//  UIView+Extensions.swift
//  WeatherApp
//
//  Created by Tiago Flores on 02/06/2022.
//

import Foundation
import UIKit

extension UIView {
    
    static var nib: UINib {
           return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static var strIdentifier: String {
        return NSStringFromClass(self)
    }
    
}
