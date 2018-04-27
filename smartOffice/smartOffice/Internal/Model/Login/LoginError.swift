
import Foundation

struct LoginError: Codable {
    let code: Int
    let message: String
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}


