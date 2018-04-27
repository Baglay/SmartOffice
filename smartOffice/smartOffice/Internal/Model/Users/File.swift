// To parse the JSON, add this file to your project and do:
//
//   let pokedex = try Pokedex(json)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responsePokedex { response in
//     if let pokedex = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

struct Pokedex: Codable {
    let pokemon: [Pokemon]
    
    enum CodingKeys: String, CodingKey {
        case pokemon = "pokemon"
    }
}

struct Pokemon: Codable {
    let id: Int
    let num: String
    let name: String
    let img: String
    let type: [String]
    let height: String
    let weight: String
    let candy: String
    let candyCount: Int?
    let egg: Egg
    let spawnChance: Double
    let avgSpawns: Double
    let spawnTime: String
    let multipliers: [Double]?
    let weaknesses: [Weakness]
    let nextEvolution: [Evolution]?
    let prevEvolution: [Evolution]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case num = "num"
        case name = "name"
        case img = "img"
        case type = "type"
        case height = "height"
        case weight = "weight"
        case candy = "candy"
        case candyCount = "candy_count"
        case egg = "egg"
        case spawnChance = "spawn_chance"
        case avgSpawns = "avg_spawns"
        case spawnTime = "spawn_time"
        case multipliers = "multipliers"
        case weaknesses = "weaknesses"
        case nextEvolution = "next_evolution"
        case prevEvolution = "prev_evolution"
    }
}

enum Egg: String, Codable {
    case notInEggs = "Not in Eggs"
    case omanyteCandy = "Omanyte Candy"
    case the10KM = "10 km"
    case the2KM = "2 km"
    case the5KM = "5 km"
}

struct Evolution: Codable {
    let num: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case num = "num"
        case name = "name"
    }
}

enum Weakness: String, Codable {
    case bug = "Bug"
    case dark = "Dark"
    case dragon = "Dragon"
    case electric = "Electric"
    case fairy = "Fairy"
    case fighting = "Fighting"
    case fire = "Fire"
    case flying = "Flying"
    case ghost = "Ghost"
    case grass = "Grass"
    case ground = "Ground"
    case ice = "Ice"
    case poison = "Poison"
    case psychic = "Psychic"
    case rock = "Rock"
    case steel = "Steel"
    case water = "Water"
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responsePokedex(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Pokedex>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

// MARK: Convenience initializers

extension Pokedex {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Pokedex.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Pokemon {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Pokemon.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Evolution {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Evolution.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
