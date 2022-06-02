//
//  UITableView+Extension.swift
//  WeatherApp
//
//  Created by Tiago Flores on 02/06/2022.
//

import UIKit

extension UITableView {
    
    public func registerNib<T: UITableViewCell>(cellClass: T.Type) {
        self.register(
            cellClass.nib,
                    forCellReuseIdentifier: cellClass.strIdentifier)
    }
    
    public func dequeue<T: UITableViewCell>(cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.strIdentifier) as? T
    }

    public func dequeue<T: UITableViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellClass.strIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Error: cell with id: \(cellClass.strIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
    
}
