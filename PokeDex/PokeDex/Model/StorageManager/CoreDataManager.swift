//
//  CoreDataManager.swift
//  PokeDex
//
//  Created by 장상경 on 1/4/25.
//

import UIKit
import CoreData

protocol CoreDataManaged: AnyObject {
    func savedPokemon()
    func readAllData()
    func updatePokemon()
    func deletePokemon()
}
