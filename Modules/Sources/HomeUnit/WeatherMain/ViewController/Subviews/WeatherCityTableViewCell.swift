//
//  WeatherCityTableViewCell.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit
import SnapKit

final class WeatherCityTableViewCell: UITableViewCell {
    
    // MARK: UI elements
    
    /// Контент стак
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            cityNameLabel, temperatureLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    /// Название города
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()
    
    /// Температура
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func configureViewModel(_ model: WeatherCityTableViewModel) {
        cityNameLabel.text = model.cityName
        temperatureLabel.text = model.temperature
    }
}

// MARK: - Private methods

private extension WeatherCityTableViewCell {
    func configure() {
        contentView.backgroundColor = .white
    }
    
    func setupLayout() {
        contentView.addSubview(contentStackView)
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
}
