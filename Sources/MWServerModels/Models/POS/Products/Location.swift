import Foundation

public struct ProductLocation_DTO {
    public struct Model: Codable {
        public var id: UUID?
        
        public var name: String
        
        public var defaultLocation: Bool
        
        public var systemUseOnly: Bool
        
        public var canBeRemoved: Bool
        
        public var increments: [ProductIncrement_DTO.V1.Model]
        
        public init (id: UUID? = nil, name: String, defaultLocation: Bool, systemUseOnly: Bool, canBeRemoved: Bool, increments: [ProductIncrement_DTO.V1.Model]) {
            self.id = id
            self.name = name
            self.defaultLocation = defaultLocation
            self.systemUseOnly = systemUseOnly
            self.canBeRemoved = canBeRemoved
            self.increments = increments
        }
    }
}
