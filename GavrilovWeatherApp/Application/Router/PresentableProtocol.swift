//
//  PresentableProtocol.swift
//  GavrilovWeatherApp
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit

protocol PresentableProtocol {
    func toPresent() -> UIViewController?
}

extension UIViewController: PresentableProtocol {
    func toPresent() -> UIViewController? {
        return self
    }
}
