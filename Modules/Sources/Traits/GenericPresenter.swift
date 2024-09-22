//
//  GenericPresenter.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

public protocol GenericPresenter {
    associatedtype ViewEvent
    
    /// Отправить ивент в презентер
    func onEvent(_ event: ViewEvent)
}
