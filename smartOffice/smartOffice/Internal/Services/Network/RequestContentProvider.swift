
import Foundation
import Alamofire

enum RequestContentProvider: URLRequestConvertible {
    
    static let baseURLString = "http://somibo.ccrowd.in/somi_bo/api/v1"
    static  let id = "somiuser"
    static let authToken = "rFKiHFJrC04aYsI9o"
    
    case userLogin(String)
    case basicAuth
    case usersInfo(String)
    case userAccountInfo(String,String,String)
    case userTimeStatistic(String,String,String)
    
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .userLogin:
            return .post
        case .basicAuth:
            return .post
        case .usersInfo:
            return .get
        case .userAccountInfo:
            return .get
        case .userTimeStatistic:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .userLogin:
            return "/auth"
        case .basicAuth:
            return "/auth"
        case .usersInfo:
            return "/users/info"
        case .userAccountInfo(let uid, let aid, _):
            return "/account/\(uid)/\(aid)"
        case .userTimeStatistic:
            return "/users/time"
        }
    }
    
    
    var base64: String {
        let credentialData = "\(RequestContentProvider.id):\(RequestContentProvider.authToken)".data(using: .utf8)
        guard let base64Credentials = credentialData?.base64EncodedString() else {
            return ""
        }
        return base64Credentials
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: RequestContentProvider.baseURLString)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(" Basic \(RequestContentProvider.basicAuth.base64)", forHTTPHeaderField: "Authorization")
        switch self {
        case .userLogin(let parameters):
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = parameters.data(using: .utf8)
            let urlParameters = ["mode": "login"]
            return try URLEncoding.queryString.encode(urlRequest, with: urlParameters)
        case .usersInfo(let token):
            let bearer = String(format:"Bearer %@", token)
            urlRequest.setValue(bearer, forHTTPHeaderField: "X-Api-Authorization")
            return urlRequest
        case .userAccountInfo(_, _, let token):
            let bearer = String(format:"Bearer %@", token)
            urlRequest.setValue(bearer, forHTTPHeaderField: "X-Api-Authorization")
            return urlRequest
        case .userTimeStatistic(_, _, let token):
            let urlParameters = ["sort": "", "groupby": ""]
            let bearer = String(format:"Bearer %@", token)
            urlRequest.setValue(bearer, forHTTPHeaderField: "X-Api-Authorization")
            return try URLEncoding.queryString.encode(urlRequest, with: urlParameters)
        default:
            return urlRequest
        }
    }
}

