//
//  ViewController.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import UIKit
import Resolver


final class WeatherListViewController: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    
    private let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
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
        tableView.registerNib(cellClass: WeatherDaysTableViewCell.self)
    }

}


// MARK: UITableViewDataSource
extension WeatherListViewController: UITableViewDataSource {
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.numberItems()
  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeue(cellClass: WeatherDaysTableViewCell.self) else {
            return UITableViewCell()
        }
        
        let itemPresenter = presenter.item(at: indexPath)
       
        cell.configure(presenter: itemPresenter)
        return cell
    }
    
}

// MARK: WeatherViewReceiver
extension WeatherListViewController: WeatherViewReceiverProtocol {
    
    func showLoading() {
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
    }
    
    func hideLoading() {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.removeFromSuperview()
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
                     
    
    func reloadData() {
        tableView.reloadData()
    }
    
}


