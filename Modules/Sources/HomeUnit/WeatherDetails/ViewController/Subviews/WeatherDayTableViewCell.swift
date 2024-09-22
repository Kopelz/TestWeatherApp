//
//  WeatherDayTableViewCell.swift
//  Modules
//
//  Created by Nikita Gavrilov on 22.09.2024.
//

import UIKit
import SnapKit

final class WeatherDayTableViewCell: UITableViewCell {
    
    // MARK: UI elements
    
    /// Контент стак
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            dayDateLabel, temperatureLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    /// День
    private let dayDateLabel: UILabel = {
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
    
    func configureViewModel(_ model: WeatherDayTableViewModel) {
        dayDateLabel.text = model.dayDate
        temperatureLabel.text = model.temperature
    }
    
    // MARK: Override
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - Private methods

private extension WeatherDayTableViewCell {
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
