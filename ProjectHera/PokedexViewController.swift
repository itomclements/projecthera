//
//  PokedexViewController.swift
//  ProjectHera
//
//  Created by Thomas Clements on 04/10/2017.
//  Copyright © 2017 Thomas Clements. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var caughtPokemons : [Pokemon] = []
    var uncaughtPokemons : [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caughtPokemons = getCaughtPokemon()
        uncaughtPokemons = getUncaughtPokemon()
        
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    
    @IBAction func mapTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Caught"
        } else {
            return "Uncaught"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return caughtPokemons.count
        } else {
            return uncaughtPokemons.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var pokemon : Pokemon
        
        if indexPath.section == 0 {
        pokemon = caughtPokemons[indexPath.row]
        } else {
          pokemon = uncaughtPokemons[indexPath.row]
        }
        cell.textLabel?.text = pokemon.name
        if let imageName = pokemon.imageName{
        cell.imageView?.image = UIImage(named: imageName)
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}
