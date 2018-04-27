
import Foundation

struct TimeStatistic: Codable {
    let sort: String
    let groupby: String
    let items: [UserTimeStatistic]
    
    enum CodingKeys: String, CodingKey {
        case sort = "sort"
        case groupby = "groupby"
        case items = "items"
    }
}


struct UserTimeStatistic: Codable {
    let id: Int
    let firstAccess: String
    let lastAccess: String
    let workTime: String
    let isClass: String
    let group: String
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstAccess = "first_access"
        case lastAccess = "last_access"
        case workTime = "work_time"
        case isClass = "class"
        case group = "group"
    }
}
