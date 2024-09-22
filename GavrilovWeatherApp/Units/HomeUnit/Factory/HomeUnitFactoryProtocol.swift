//
//  HomeUnitFactoryProtocol.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import HomeUnit
import Combine

protocol HomeUnitFactoryProtocol {
    func makeWeatherMainUnit(output: WeatherMainUnitOutput,
                             updateEventPublisher: AnyPublisher<HomeUnitEvent, Never>) -> PresentableProtocol
    
    func makeWeatherSearchUnit(output: WeatherSearchUnitOutput,
                               updateEventPublisher: AnyPublisher<HomeUnitEvent, Never>) -> PresentableProtocol
    
    func makeWeatherDetailsUnit(output: WeatherDetailsUnitOutput, cityData: CityData) -> PresentableProtocol
}
