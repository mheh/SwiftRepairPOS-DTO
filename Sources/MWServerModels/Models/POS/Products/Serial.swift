import Foundation

public struct SerialNumber_DTO {
    public enum V1 {}
}


// MARK: V1
private typealias V1 = SerialNumber_DTO.V1

extension V1 {
    // MARK: Models
    
    /// The model returned from the server
    public struct Model: Codable, Identifiable {
        /// This server's unique ID
        public var id: Int
        

        public var createdAt: Date
        public var updatedAt: Date

        /// The serial number for this model
        public var serialNumber: String
        
        /// The parent `Product` model this serial number is associated with
        public var productID: Product_DTO.V1.Model
        /// Where this serial number is currently located
        public var locationID: ProductLocation_DTO.Model
        
        /// Whether this serial number has been sold
        public var isSold: Bool
        
        /// `ProductIncrement` models associated with this serial number
        public var increments: [ProductIncrement_DTO.V1.Model]
        
        public init(
            id: Int, 
            createdAt: Date,
            updatedAt: Date,
            serialNumber: String,
            productID: Product_DTO.V1.Model,
            locationID: ProductLocation_DTO.Model,
            isSold: Bool,
            increments: [ProductIncrement_DTO.V1.Model]
        ) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.serialNumber = serialNumber
            self.productID = productID
            self.locationID = locationID
            self.isSold = isSold
            self.increments = increments
        }
    }

    /// Create a new `SerialNumber` in the system for an existing`Product` model
    public struct CreateRequestModel {
        /// The serial number to add
        public var serialNumber: String
        
        /// The product ID this serial number is associated with
        public var productID: Int
        
        public init(serialNumber: String, productID: Int) {
            self.serialNumber = serialNumber
            self.productID = productID
        }
    }
}
