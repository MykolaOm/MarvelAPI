//
//  ModuleBuilder.swift
//  ComixCards
//
//  Created by Nikolas Omelianov on 08.06.2020.
//  Copyright © 2020 Nikolas Omelianov. All rights reserved.
//

import UIKit

protocol MarvelBuilderProtocol {
    func createMainModule(router: MarvelRouterProtocol) -> UIViewController
    func createHeroModule(heroId: String, router: MarvelRouterProtocol) -> UIViewController
}

class MarvelModuleBuilder: MarvelBuilderProtocol {
    func createMainModule(router: MarvelRouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = MarvelNetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        
        return view
    }
    func createHeroModule(heroId: String, router: MarvelRouterProtocol) -> UIViewController {
        let view = MarvelHeroViewController()
        let networkService = MarvelNetworkService()
        let presenter = MarvelHeroPresenter(view: view, networkService: networkService, heroId: heroId, router: router)
        view.presenter = presenter
        
        return view
    }
}
