//
//  ModuleBuilder.swift
//  ComixCards
//
//  Created by Nikolas Omelianov on 08.06.2020.
//  Copyright © 2020 Nikolas Omelianov. All rights reserved.
//

import UIKit

protocol MarvelBuilderProtocol {
    static func createMainModule() -> UIViewController
    static func createHeroModule(heroId: String) -> UIViewController
}

class MarvelModuleBuilder: MarvelBuilderProtocol {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = MarvelNetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
    static func createHeroModule(heroId: String) -> UIViewController {
        let view = MarvelHeroViewController()
        let networkService = MarvelNetworkService()
        let presenter = MarvelHeroPresenter(view: view, networkService: networkService, heroId: heroId)
        view.presenter = presenter
        
        return view
    }
}
