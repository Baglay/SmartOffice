

import Foundation

struct AllError: Codable, Error {
    let error: LoginError
    
    
    init(error: LoginError) {
        self.error = error
    }
}
