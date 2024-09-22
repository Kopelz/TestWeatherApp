//
//  WeatherMainViewController.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit
import Traits
import Combine

final class WeatherMainViewController: BaseViewController<WeatherMainView> {
    
    typealias DataSource = UITableViewDiffableDataSource<WeatherMainSection, WeatherMainItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<WeatherMainSection, WeatherMainItem>
    
    // MARK: Properties
    
    var cancelables = Set<AnyCancellable>()
    var presenter: (any WeatherMainPresenterProtocol)?
    
    private lazy var weatherCities: DataSource = {
        let weatherCities = DataSource(tableView: rootView.weatherCitiesTableView) { [unowned self]
            tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case let .weatherCity(model):
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherCityTableViewCell.self), for: indexPath) as? WeatherCityTableViewCell {
                    cell.configureViewModel(model)
                    return cell
                }
            }
            return UITableViewCell()
        }
        return weatherCities
    }()
    
    // MARK: Init
    
    init(presenter: (any WeatherMainPresenterProtocol)?) {
        self.presenter = presenter
        
        let view = WeatherMainView(frame: .zero)
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

private extension WeatherMainViewController {
    func configure() {
        title = "Погода"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCityButton))
        
        rootView.weatherCitiesTableView.dataSource = weatherCities
        rootView.weatherCitiesTableView.delegate = self
        rootView.weatherCitiesTableView.register(WeatherCityTableViewCell.self,
                                          forCellReuseIdentifier: String(describing: WeatherCityTableViewCell.self))
    }
    
    func subscribeUpdates() {
        presenter?.weatherCities
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
                weatherCities.apply(snapshot, animatingDifferences: false)
                rootView.weatherCitiesTableView.reloadData()
            }
            .store(in: &cancelables)
    }
    
    @objc func addCityButton() {
        presenter?.onEvent(.tappedAddCity)
    }
}

// MARK: - UITableViewDelegate

extension WeatherMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = weatherCities.snapshot().itemIdentifiers[indexPath.row]
        
        switch cell {
        case let .weatherCity(model):
            presenter?.onEvent(.needOpenDetails(city: model.cityName ?? ""))
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        
        let cell = weatherCities.snapshot().itemIdentifiers[indexPath.row]

        let actionDelete = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
            
            switch cell {
            case let .weatherCity(model):
                self?.presenter?.onEvent(.needDelete(city: model.cityName ?? ""))
            }
            
            completion(true)
        }
        actionDelete.backgroundColor = .red
        actionDelete.image = .remove

        let configuration = UISwipeActionsConfiguration(actions: [actionDelete])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
