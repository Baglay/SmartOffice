
import Foundation


enum UsersResult<A: Codable> {
    case success (A)
    case failure(Error)
}

struct Users: Codable {
    let items: [User]
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}

struct User: Codable {
    let uid: String
    let name: String
    let role: String
    let image: String
    let email: String
    let accounts: [Accounts]
}



struct Accounts: Codable {
    let id: Int
    let balance: Int
}
struct UserAccountInfo: Codable {
    let id: Int
    let currency: String
    let image: String
    let balance: Int
}

