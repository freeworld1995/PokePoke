//
//  DatabaseManager.swift
//  pokemon
//
//  Created by Jimmy Hoang on 1/16/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import Foundation

class DatabaseManager {
    static var destinationPath: String {
        let libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        let destination = libraryPath + "/pokemon.db"
        return destination
    }
    
    static func copyDatabaseIfNeed() {
        let databasePath = Bundle.main.path(forResource: "pokemon", ofType: "db")
        
         print(destinationPath)
        
        if !FileManager.default.fileExists(atPath: destinationPath) {
            try! FileManager.default.copyItem(atPath: databasePath!, toPath: destinationPath)
        }
    }
    
    static func initDatabase() -> FMDatabase? {
        guard let database = FMDatabase(path: DatabaseManager.destinationPath) else {
            return nil
        }
        
        guard database.open() else {
            return nil
        }
        
        return database
    }
    
    static func selectAllPokemons() -> [pokemon]? {
        guard let database = initDatabase() else { return nil }
        
        var pokemons: [pokemon] = []
        let genArray = UserDefaults.standard.object(forKey: "generations") as! [Int]?
        
        let whereQuery = generateWhereGenerationQuery(generations: genArray!)
        
        do {
            let rs = try database.executeQuery("SELECT * FROM pokemon " + whereQuery!, values: nil)
            while rs.next() {
                if let id = Int(rs.string(forColumn: "id")),
                    let name = rs.string(forColumn: "name"),
                    let tag = rs.string(forColumn: "tag"),
                    let gen = Int(rs.string(forColumn: "gen")),
                    let imgURL = rs.string(forColumn: "img"),
                    let color = rs.string(forColumn: "color") {
                    
                    let p = pokemon(id: id, name: name, tag: tag, gen: gen, imgURL: imgURL, color: color)
                    pokemons.append(p)
                }
            }
        } catch {
            print("Error: \(error)")
        }
        
        return pokemons
    }
    
    static func generateWhereGenerationQuery(generations: [Int]) -> String? {
        let startQuery = "WHERE "
        
        if generations.count <= 1 {
            let bodyQuery = "gen = \(generations[0])"
            return startQuery + bodyQuery
        } else {
            var bodyQuery = ""
            
            for i in 0..<generations.count {
                if i != generations.count - 1 {
                    bodyQuery += " gen = \(generations[i]) OR "
                }
                else {
                    bodyQuery += "gen = \(generations[i])"
                }
            }
            return startQuery + bodyQuery
        }
    }
    
}
