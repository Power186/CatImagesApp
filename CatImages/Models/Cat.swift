import Foundation

struct Cat: Identifiable, Codable {
    var id: String = UUID().uuidString
    var catId: String?
    
    private enum CodingKeys: String, CodingKey {
        case catId = "_id"
    }
}

// MARK: - Extensions

extension Cat: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
