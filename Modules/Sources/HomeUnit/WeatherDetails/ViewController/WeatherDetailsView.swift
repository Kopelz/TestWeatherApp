//
//  WeatherDetailsView.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit
import SnapKit

final class WeatherDetailsView: UIView {
    
    // MARK: UI elements
    
    lazy var weatherDaysTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension WeatherDetailsView {
    func configure() {
        backgroundColor = .white
    }
    
    func setupLayout() {
        addSubview(weatherDaysTableView)
        
        weatherDaysTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalTo(safeAreaLayoutGuide.snp.left)
            make.right.equalTo(safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(snp.bottom)
        }
    }
}
