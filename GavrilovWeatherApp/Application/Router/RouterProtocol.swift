//
//  RouterProtocol.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

protocol RouterProtocol {
    func present(_ module: PresentableProtocol)
    func dismissLastPresented()
}
