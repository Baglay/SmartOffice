import Foundation

protocol Contextual {
    var context: Context? { get set }
}

// 'ServiceLocator' pattern
class Context {
    let usersManager: ServiceManager
    
    init(usersManager: ServiceManager) {
        self.usersManager = usersManager
    }
}

extension Context {
    
    static func createStorageContext() -> Context? {
        let context = Context(
            usersManager: ServiceManager()
        )
        return context
    }
}
