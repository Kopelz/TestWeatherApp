//
//  BaseViewController.swift
//  Modules
//
//  Created by Nikita Gavrilov on 21.09.2024.
//

import UIKit

open class BaseViewController<RootView: UIView>: UIViewController {
    public let rootView: RootView
    
    public init(rootView: RootView) {
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = rootView
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
