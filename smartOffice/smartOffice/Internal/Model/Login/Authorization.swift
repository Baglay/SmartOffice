
import Foundation

struct Authorization: Codable {
    let access_token: AccessToken
    
    init(access_token: AccessToken) {
        self.access_token = access_token
    }
}
