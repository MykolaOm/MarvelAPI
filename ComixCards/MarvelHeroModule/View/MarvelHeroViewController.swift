//
//  MarvelHeroViewController.swift
//  ComixCards
//
//  Created by Nikolas Omelianov on 15.06.2020.
//  Copyright © 2020 Nikolas Omelianov. All rights reserved.
//

import UIKit

class MarvelHeroViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var presenter: MarvelHeroViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        presenter.getHeroComixes()
        // Do any additional setup after loading the view.
    }

}

extension MarvelHeroViewController: MarvelHeroViewProtocol {
    func getHeroComixes(heroId: String) {
        //networkService getComixes...
    }
}

extension MarvelHeroViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return presenter.heroSeries.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let marvel = presenter.heroSeries?......
        cell.textLabel?.text = "marvel?.name"
        return cell
    }
    
    
}

