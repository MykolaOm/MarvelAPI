//
//  MainPresenter.swift
//  ComixCards
//
//  Created by Nikolas Omelianov on 08.06.2020.
//  Copyright © 2020 Nikolas Omelianov. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    func success()
    func failure(error: Error)
    
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: MarvelNetworkServiceProtocol, router: MarvelRouterProtocol )
    func getMarvel()
    var marvel: Marvel? { get set }
    func chooseHero(heroId: String?)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: MarvelNetworkServiceProtocol!
    var marvel: Marvel?
    var router: MarvelRouterProtocol?
    func getMarvel() {
        networkService.getMarvel { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let marv):
                self.marvel = marv
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
            
        }
    }
    func chooseHero(heroId: String?) {
        guard let id = heroId else { return }
        router?.heroViewController(heroId: id)
    }
    
    
    required init(view: MainViewProtocol, networkService: MarvelNetworkServiceProtocol, router: MarvelRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getMarvel()
    }
    

    
}
