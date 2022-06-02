//
//  ViewController.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import UIKit
import Resolver

extension UIView {
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableView {
    
    public func register<T: UITableViewCell>(cellClass: T.Type) {
        register(UINib(nibName:  cellClass.reuseIdentifier, bundle:  nil), forCellReuseIdentifier:  cellClass.reuseIdentifier)
    }
    
    public func dequeue<T: UITableViewCell>(cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as? T
    }

    public func dequeue<T: UITableViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Error: cell with id: \(cellClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
    
}

extension UICollectionView {
    
    public func register<T: UICollectionViewCell>(cellClass: T.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
    
}


final class WeatherListViewController: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    
    @Injected var presenter: WeatherListPresenterProtocol
    
    init(presenter: WeatherListPresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        presenter.bindView(view: self)
        presenter.loadData()
    }
    
    
    
    private func setupTableview() {
        
        tableView.register(
            WeatherDaysTableViewCell.nib,
                    forCellReuseIdentifier: WeatherDaysTableViewCell.reuseIdentifier)
    }

}


// MARK: UITableViewDataSource
extension WeatherListViewController: UITableViewDataSource {
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.numberItems()
  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDaysTableViewCell.reuseIdentifier) as? WeatherDaysTableViewCell  else {
            return UITableViewCell()
        }
        
        let itemPresenter = presenter.item(at: indexPath)
        cell.configure(presenter: itemPresenter)
        return cell
    }
    
}

// MARK: WeatherViewReceiver
extension WeatherListViewController: WeatherViewReceiver {
    
    func reloadData() {
        tableView.reloadData()
    }
    
}


