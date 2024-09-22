//
//  WeatherDetailsViewController.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit
import Traits
import Combine

final class WeatherDetailsViewController: BaseViewController<WeatherDetailsView> {
    
    typealias DataSource = UITableViewDiffableDataSource<WeatherDetailsSection, WeatherDetailsItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<WeatherDetailsSection, WeatherDetailsItem>
    
    // MARK: Properties
    
    var cancelables = Set<AnyCancellable>()
    var presenter: (any WeatherDetailsPresenterProtocol)?
    
    private lazy var weatherDays: DataSource = {
        let weatherDays = DataSource(tableView: rootView.weatherDaysTableView) { [unowned self]
            tableView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case let .dayDate(model):
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherDayTableViewCell.self), for: indexPath) as? WeatherDayTableViewCell {
                    
                    cell.configureViewModel(model)
                    return cell
                }
            }
            
            return UITableViewCell()
        }
        return weatherDays
    }()
    
    // MARK: Init
    
    init(presenter: (any WeatherDetailsPresenterProtocol)?) {
        self.presenter = presenter
        
        let view = WeatherDetailsView(frame: .zero)
        super.init(rootView: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        subscribeUpdates()
        
        presenter?.onEvent(.viewLoaded)
    }
}

// MARK: - Private methods

private extension WeatherDetailsViewController {
    func configure() {
        rootView.weatherDaysTableView.dataSource = weatherDays
        rootView.weatherDaysTableView.delegate = self
        rootView.weatherDaysTableView.register(WeatherDayTableViewCell.self,
                                               forCellReuseIdentifier: String(describing: WeatherDayTableViewCell.self))
    }
    
    func subscribeUpdates() {
        presenter?.cityName
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] text in
                title = text
            }
            .store(in: &cancelables)
        
        presenter?.weatherForecast
            .map { items -> Snapshot in
                var snapshot = Snapshot()
                items.forEach { item in
                    if !snapshot.sectionIdentifiers.contains(item.section) {
                        snapshot.appendSections([item.section])
                    }
                    snapshot.appendItems([item], toSection: item.section)
                }
                return snapshot
            }
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] snapshot in
                weatherDays.apply(snapshot, animatingDifferences: false)
                rootView.weatherDaysTableView.reloadData()
            }
            .store(in: &cancelables)
    }
}

// MARK: - UITableViewDelegate

extension WeatherDetailsViewController: UITableViewDelegate {

}
