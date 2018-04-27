
import Foundation

struct AuthUser: Codable {
    let id: Int
    let refresh_token: String
    
    init(id: Int, refresh_token: String) {
        self.id = id
        self.refresh_token = refresh_token
    }
}
