//
//  WeatherDayCollectionViewCell.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import Foundation
import UIKit

final class WeatherDayCollectionViewCell: UICollectionViewCell {
    
 
   fileprivate enum Constants {
        static let titleLabelFontSize: CGFloat = 13
        static let weatherImageViewCornerRadius: CGFloat = 12
        static let cellCornerRadius: CGFloat = 10
    }
    
    private var presenter: WeatherDayPresenterProtocol?
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        titleTextLabel.numberOfLines = 0
        titleTextLabel.font = titleTextLabel.font.withSize(Constants.titleLabelFontSize)
        titleTextLabel.lineBreakMode = .byWordWrapping
        titleTextLabel.textColor = UIColor.black
        weatherImageView.layer.cornerRadius = Constants.weatherImageViewCornerRadius
        weatherImageView.clipsToBounds = true
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.backgroundColor = .white
        
        self.layer.cornerRadius = Constants.cellCornerRadius
        self.layer.masksToBounds = true
    }
    
    func configure(indexPath: IndexPath, with presenter: WeatherDayPresenterProtocol) {

        titleTextLabel.text = presenter.weatherDataStr(indexPath: indexPath)
        presenter.downloadImage(indexPath: indexPath) { [weak self] image in
                guard let self = self else {
                    return
                }
                self.weatherImageView.image = image
        }
    }
}
