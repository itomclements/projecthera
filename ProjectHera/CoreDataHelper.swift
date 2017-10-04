//
//  CoreDataHelper.swift
//  ProjectHera
//
//  Created by Thomas Clements on 04/10/2017.
//  Copyright © 2017 Thomas Clements. All rights reserved.
//

import UIKit
import CoreData

func addAllPokemon() {
    
    createPokemon(name: "Pikachu", imageName: "pikachu-2")
    createPokemon(name: "Meowth", imageName: "meowth")
    createPokemon(name: "Pidgey", imageName: "pidgey")
    createPokemon(name: "Zubat", imageName: "zubat")
    createPokemon(name: "Snorlax", imageName: "snorlax")
    createPokemon(name: "Psyduck", imageName: "psyduck")
    createPokemon(name: "Mew", imageName: "mew")
    createPokemon(name: "Mankey", imageName: "mankey")
    createPokemon(name: "Bullbasaur", imageName: "bullbasaur")
    createPokemon(name: "Charmander", imageName: "charmander")
    
}

func createPokemon(name:String, imageName:String){
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        let pokemon = Pokemon(entity: Pokemon.entity(), insertInto: context)
        pokemon.name = name
        pokemon.imageName = imageName
        try? context.save()
    }
}

func getAllPokemon() -> [Pokemon] {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        if let pokeData = try? context.fetch(Pokemon.fetchRequest()) as? [Pokemon] {
            if let pokemons = pokeData {
                if pokemons.count == 0 {
                    addAllPokemon()
                    return getAllPokemon()
                }
                return pokemons
            }
        }
    }
    return []
}

func getCaughtPokemon() -> [Pokemon]{
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        fetchRequest.predicate = NSPredicate(format: "caught == %@", true as CVarArg)
        if let pokemons = try? context.fetch(fetchRequest) {
           return pokemons
            }
        }
    return []
}

func getUncaughtPokemon() -> [Pokemon]{
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        fetchRequest.predicate = NSPredicate(format: "caught == %@", false as CVarArg)
        if let pokemons = try? context.fetch(fetchRequest) {
            return pokemons
        }
    }
    return []
}
