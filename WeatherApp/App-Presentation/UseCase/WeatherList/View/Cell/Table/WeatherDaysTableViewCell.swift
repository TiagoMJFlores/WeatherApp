//
//  WeatherDaysTableViewCell.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import Foundation
import UIKit

final class WeatherDaysTableViewCell: UITableViewCell {
    
    fileprivate enum Constants {
        static let collectionViewHeight: CGFloat = 160
        static let collectionInsets: CGFloat = 16
    }
    

    private var presenter: WeatherDayPresenterProtocol?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    func configure(presenter: WeatherDayPresenterProtocol) {
        self.selectionStyle = .none
        self.presenter = presenter
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        titleLabel.textAlignment = .center;
        collectionView.registerNib(cellClass: WeatherDayCollectionViewCell.self)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension WeatherDaysTableViewCell: UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberItems() ?? 0
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellClass: WeatherDayCollectionViewCell.self, forIndexPath: indexPath)
        guard
              let presenter = presenter else {
            return UICollectionViewCell()
        }
  
        cell.backgroundColor = UIColor.gray
        titleLabel.text = presenter.weatherData.day
        cell.configure( indexPath: indexPath, with: presenter)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let result =  CGSize(width: contentView.bounds.width / 2 - Constants.collectionInsets * 2, height: Constants.collectionViewHeight)
        return result
    }
    
}
