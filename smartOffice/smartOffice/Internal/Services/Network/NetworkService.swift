 
import Foundation
import Alamofire

struct ResponseResult: Codable {
}

enum RequestResult<T: Codable> {
    case success (T)
    case failure(Error)
}

class NetworkService {
    
    func login (parameters: String, completion: @escaping (RequestResult<UserInfo>) -> Void) {
        let apiTask = APITask<UserInfo>(urlRequest: try! RequestContentProvider.userLogin(parameters).asURLRequest(), completion: completion)
        let requestManager = RequestManager()
        requestManager.runTask(apiTask)
    }
    
    func getUsers (token: String, completion: @escaping (RequestResult<Users>) -> Void) {
        let apiTask = APITask<Users>(urlRequest: try! RequestContentProvider.usersInfo(token).asURLRequest(), completion: completion)
        let requestManager = RequestManager()
        requestManager.runTask(apiTask)
    }
    
    func getUserAccountInfo (uid:String, aid: String, token: String, completion: @escaping (RequestResult<UserAccountInfo>) -> Void) {
        let apiTask = APITask<UserAccountInfo>(urlRequest: try! RequestContentProvider.userAccountInfo(uid, aid, token).asURLRequest(), completion: completion)
        let requestManager = RequestManager()
        requestManager.runTask(apiTask)
    }
    
    func getUserTimeStatistic (sort:String, groupby: String, token: String,  completion: @escaping (RequestResult<TimeStatistic>) -> Void) {
        let apiTask = APITask<TimeStatistic>(urlRequest: try! RequestContentProvider.userTimeStatistic(sort, groupby, token).asURLRequest(), completion: completion)
        let requestManager = RequestManager()
        requestManager.runTask(apiTask)
    }
}

private extension NetworkService {
    func runRequest<T>(task: APITask<T>) {
        let requestManager = RequestManager()
        requestManager.runTask(task)
    }
}

