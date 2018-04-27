

import Foundation
import Alamofire
class RequestManager {
    
    func runTask<T>(_ task: APITask<T>) {
        request(task.urlRequest).responseJSON { (response) in
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                var parseObject: T
                do {
                    parseObject =  try JSONDecoder().decode(T.self, from: data)
                    task.completion(.success(parseObject))
                }
                catch {
                    task.completion(.failure(error))
                    print(error)
                }
            case .failure(let error):
                task.completion(.failure(error))
            }
        }
    }
}
