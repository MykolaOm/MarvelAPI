//
//  MarvelHeroPresenter.swift
//  ComixCards
//
//  Created by Nikolas Omelianov on 11.06.2020.
//  Copyright © 2020 Nikolas Omelianov. All rights reserved.
//

import Foundation

protocol MarvelHeroViewProtocol:class {
    func getHeroComixes(heroId: String)
}

protocol MarvelHeroViewPresenterProtocol:class {
    init(view:MarvelHeroViewProtocol, networkService: MarvelNetworkService, heroId: String, router: MarvelRouterProtocol)
    func getHeroComixes()
    //func getBack()
    //let heroSeries: HeroSeries?
}

class MarvelHeroPresenter: MarvelHeroViewPresenterProtocol {
    weak var view: MarvelHeroViewProtocol?
    let networkService: MarvelNetworkService!
    let heroId: String
    var router: MarvelRouterProtocol?
    
    required init(view: MarvelHeroViewProtocol, networkService: MarvelNetworkService, heroId: String, router: MarvelRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.heroId = heroId
        self.router = router
        getHeroComixes()
        
    }
    
    func getHeroComixes() {
        //networkService.getHeroComixes....
    }
    func getBack(){
        self.router?.popToRoot()
    }

}
