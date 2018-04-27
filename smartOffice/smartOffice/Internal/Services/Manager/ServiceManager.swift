
import Foundation

typealias block<T:Codable> = (UserResult<T>) -> ()

enum UserResult<T: Codable> {
    case success (T)
    case failure(LoginError)
}


class ServiceManager {
    
    var users : [User] = []
    private var network: NetworkService = NetworkService()
    
//    func loginBasicAuth(completion: @escaping block<UserInfo>) {
//        network.loginBasicAuth { (requestResponse) in
//            switch requestResponse {
//            case .success(let userInfo):
//                completion(.success(userInfo))
//            case .failure(let error):
//                completion(.failure(error as! LoginError))
//            }
//        }
//    }
    
    func login(parameters: String,  completion: @escaping block<UserInfo> ) {
        network.login(parameters: parameters) { (requestResponse) in
            switch requestResponse {
            case .success(let userInfo):
                completion(.success(userInfo))
            case .failure(let error):
                completion(.failure(error as! LoginError))
            }
        }
    }
    
    func getAllUsers(token: String, completion: @escaping block<[User]>) {
        network.getUsers(token: token) { (requestResponse) in
            switch requestResponse {
            case .success(let users):
                //self.users = [users]
                self.users = users.items
                completion(.success(users.items))
            case .failure(let error):
                completion(.failure(error as! LoginError))
            }
        }
    }
    
    func getUserAccountInfo(uid: String, aid: String, token: String, completion: @escaping block<UserAccountInfo>) {
        network.getUserAccountInfo(uid: uid, aid: aid, token: token, completion: { requestResponse in
            switch requestResponse {
            case .success(let userAccountInfo):
                //self.users = [users]
              //  self.users = users.items
                completion(.success(userAccountInfo))
            case .failure(let error):
                completion(.failure(error as! LoginError))
            }
        }
    )}
    
    func getUserTimeStatistic (sort:String, groupby: String, token: String,  completion: @escaping block <TimeStatistic>) {
        network.getUserTimeStatistic(sort: sort, groupby: groupby, token: token) { (requestResponse) in
            switch requestResponse {
            case .success(let userTimeStatistic):
                completion(.success(userTimeStatistic))
            case .failure(let error):
                completion(.failure(error as! LoginError))
            }
        }
    }
}
