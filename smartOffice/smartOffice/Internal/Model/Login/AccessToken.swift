
import Foundation

struct AccessToken: Codable {
    let token_type: String
    let expires_in: Int
    let value: String
    
    init(token_type: String, expires_in: Int, value: String) {
        self.token_type = token_type
        self.expires_in = expires_in
        self.value = value
    }
}

