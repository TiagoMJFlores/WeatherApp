//
//  UICollectionView+Extension.swift
//  WeatherApp
//
//  Created by Tiago Flores on 02/06/2022.
//


import UIKit

extension UICollectionView {
    
    public func registerNib<T: UICollectionViewCell>(cellClass: T.Type) {
        self.register(
            cellClass.nib,
            forCellWithReuseIdentifier: cellClass.strIdentifier)
    }
    


    public func dequeue<T: UICollectionViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: cellClass.strIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Error: cell with id: \(cellClass.strIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
    
}
