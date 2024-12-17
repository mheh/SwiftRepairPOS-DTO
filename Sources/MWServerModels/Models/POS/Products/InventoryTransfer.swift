public struct ProductInventoryTransfer_DTO {
    public struct Model: Codable {
        public var id: Int?
        public var type: String
        
        public var fromLocationID: ProductLocation_DTO.Model?
        public var toLocationID: ProductLocation_DTO.Model
        
        public var fromIncrementID: ProductIncrement_DTO.V1.Model?
        public var toIncrementID: ProductIncrement_DTO.V1.Model
        
        public var userID: User_DTO.V1.Model
        public var notes: String
        
        public init (id: Int? = nil, type: String, fromLocationID: ProductLocation_DTO.Model?, toLocationID: ProductLocation_DTO.Model, fromIncrementID: ProductIncrement_DTO.V1.Model?, toIncrementID: ProductIncrement_DTO.V1.Model, userID: User_DTO.V1.Model, notes: String) {
            self.id = id
            self.type = type
            self.fromLocationID = fromLocationID
            self.toLocationID = toLocationID
            self.fromIncrementID = fromIncrementID
            self.toIncrementID = toIncrementID
            self.userID = userID
            self.notes = notes
        }
    }
}
