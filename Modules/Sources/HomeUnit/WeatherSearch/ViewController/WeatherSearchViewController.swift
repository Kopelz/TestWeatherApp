//
//  WeatherSearchViewController.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit
import Traits
import Combine

final class WeatherSearchViewController: BaseViewController<WeatherSearchView> {
    
    typealias DataSource = UITableViewDiffableDataSource<WeatherSearchSection, WeatherSearchItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<WeatherSearchSection, WeatherSearchItem>
    
    // MARK: Properties
    
    var cancelables = Set<AnyCancellable>()
    var presenter: (any WeatherSearchPresenterProtocol)?
    
    private lazy var cities: DataSource = {
        let cities = DataSource(tableView: rootView.suggestCityTableView) { [unowned self]
            tableView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case let .city(model):
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SuggestCityTableViewCell.self), for: indexPath) as? SuggestCityTableViewCell {
                    
                    cell.configureViewModel(model)
                    return cell
                }
            }
            
            return UITableViewCell()
        }
        return cities
    }()
    
    // MARK: Init
    
    init(presenter: (any WeatherSearchPresenterProtocol)?) {
        self.presenter = presenter
        
        let view = WeatherSearchView(frame: .zero)
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
    }
}

// MARK: - Private methods

private extension WeatherSearchViewController {
    func configure() {
        title = "Поиск"
        rootView.searchController.searchResultsUpdater = self
        navigationItem.searchController = rootView.searchController
        
        rootView.suggestCityTableView.dataSource = cities
        rootView.suggestCityTableView.delegate = self
        rootView.suggestCityTableView.register(SuggestCityTableViewCell.self,
                                          forCellReuseIdentifier: String(describing: SuggestCityTableViewCell.self))
    }
    
    func subscribeUpdates() {
        presenter?.searchSuggest
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
                cities.apply(snapshot, animatingDifferences: false)
                rootView.suggestCityTableView.reloadData()
            }
            .store(in: &cancelables)
    }
}

// MARK: - UISearchResultsUpdating

extension WeatherSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            presenter?.onEvent(.searchTextChanged(text))
        }
    }
}

// MARK: - UITableViewDelegate

extension WeatherSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = cities.snapshot().itemIdentifiers[indexPath.row]
        
        switch cell {
        case let .city(model):
            presenter?.onEvent(.selectedSuggestCity(model.cityName ?? ""))
        }
    }
}
