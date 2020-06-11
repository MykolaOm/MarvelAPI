//
//  Router.swift
//  ComixCards
//
//  Created by Nikolas Omelianov on 12.06.2020.
//  Copyright © 2020 Nikolas Omelianov. All rights reserved.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController? { get set }
    var builder: MarvelBuilderProtocol? { get set }
}

protocol MarvelRouterProtocol: RouterProtocol {
    func initialViewController()
    func heroViewController(heroId: String)
    func popToRoot()
}

class MarvelRouter: MarvelRouterProtocol {
    var navigationController: UINavigationController?
    var builder: MarvelBuilderProtocol?
    
    init(navigationController: UINavigationController, builder: MarvelBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    func initialViewController() {
        if let nC = self.navigationController {
            guard let mainViewController = builder?.createMainModule(router: self) else { return  }
            nC.viewControllers = [mainViewController]
        }
    }
    
    func heroViewController(heroId: String) {
        if let nC = self.navigationController {
            guard let heroModule = builder?.createHeroModule(heroId: heroId, router: self) else { return }
            nC.pushViewController(heroModule, animated: true )
        }
    }
    
    func popToRoot() {
        if let nC = self.navigationController {
            nC.popToRootViewController(animated: true)
        }
    }
    
   
    
    
}

