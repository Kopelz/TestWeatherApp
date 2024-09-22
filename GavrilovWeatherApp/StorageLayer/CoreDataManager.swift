//
//  CoreDataManager.swift
//  Modules
//
//  Created by Nikita Gavrilov on 22.09.2024.
//

import CoreData
import HomeUnit

public final class CoreDataManager {
    
    // MARK: Properties
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherData")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    // MARK: Init
    
    public init() {}
}

// MARK: - Private methods

private extension CoreDataManager {
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: - CoreDataWeatherProtocol

extension CoreDataManager: CoreDataWeatherProtocol {
    public func addCity(_ name: String, lat: Double, lon: Double) {
        guard let entity = NSEntityDescription.entity(forEntityName: "WeatherCityCoreData", in: context) else { return }
        
        let city = WeatherCityCoreData(entity: entity, insertInto: context)
        city.nameCity = name
        city.lat = lat
        city.lon = lon
        
        saveContext()
    }
    
    public func fetchCities() -> [CitySaved] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherCityCoreData")
        do {
            return (try? context.fetch(request) as? [WeatherCityCoreData]) ?? []
        }
    }
    
    public func deleteCity(_ name: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherCityCoreData")
        do {
            guard let cities = try? context.fetch(request) as? [WeatherCityCoreData],
            let city = cities.first(where: { $0.nameCity == name }) else { return }
            context.delete(city)
        }
        
        saveContext()
    }
}
