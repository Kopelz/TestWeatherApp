//
//  SuggestCityTableViewCell.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit
import SnapKit

final class SuggestCityTableViewCell: UITableViewCell {
    
    // MARK: UI elements
    
    /// Название города
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
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
    
    func configureViewModel(_ model: SuggestCityTableViewModel) {
        cityNameLabel.text = model.cityName
    }
    
    // MARK: Override
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - Private methods

private extension SuggestCityTableViewCell {
    func configure() {
        contentView.backgroundColor = .white
    }
    
    func setupLayout() {
        contentView.addSubview(cityNameLabel)
        
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}
