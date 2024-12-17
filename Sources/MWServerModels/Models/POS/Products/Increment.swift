import Foundation

public struct ProductIncrement_DTO {
    public enum V1 {}
}

extension ProductIncrement_DTO.V1 {
    /// The base path for accessing Increments
    /// Increments are only accessible through a provided product
    public static var basePath: String = "products"
    
    /// Model returned from the server
    public struct Model: Codable, Identifiable, Hashable {
        public var id: Int
        
        public var createdAt: Date
        public var updatedAt: Date
        public var deletedAt: Date?
        
        /// Product ID
        public var productID: Int
        /// Optionally include product information for this increment
        public var product: Product_DTO.V1.Model?
        
        /// Location ID
        public var locationID: UUID
        /// Optionally include the location ID information
        public var location: ProductLocation_DTO.Model?
        
        /// Increment amount
        public var amount: Int
        /// Serial numbers associated with this increment
        public var serials: [SerialNumber_DTO.V1.Model]
        
        public init(id: Int, createdAt: Date, updatedAt: Date, deletedAt: Date? = nil, productID: Int, product: Product_DTO.V1.Model? = nil, locationID: UUID, location: ProductLocation_DTO.Model? = nil, amount: Int, serials: [SerialNumber_DTO.V1.Model]) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.deletedAt = deletedAt
            self.productID = productID
            self.product = product
            self.locationID = locationID
            self.location = location
            self.amount = amount
            self.serials = serials
        }
        
        public static func == (lhs: ProductIncrement_DTO.V1.Model, rhs: ProductIncrement_DTO.V1.Model) -> Bool {
            return lhs.id == rhs.id
        }
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    
    /// Create a new inventory increment for a product.
    /// You can only create one serialized increment at a time.
    struct CreateRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String]
        public var requestType: MWRequest_HTTPType = .POST
        public var response: Decodable.Type? = nil
        public var body: Encodable? = nil
        
        public init(
            productID: UUID,
            locationID: UUID,
            amount: Int,
            serialNumber: String?
        ) throws {
            self.path = "\(basePath)/\(productID)/increments"
            self.urlQueryParams = [
                "locationID": "\(locationID)",
                "amount": "\(amount)"
            ]
            if let serialNumber {
                self.urlQueryParams["amount"] = "1"
                self.urlQueryParams["serialNumber"] = serialNumber
            }
        }
    }
    
    /// Read all Inventory Increments for a product.
    /// Optionally filter response by Location
    /// Returns ALL (including deleted)
    struct ReadAllRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .GET
        public var response: Decodable.Type? = nil
        public var body: Encodable? = nil
        
        public init(productID: UUID, locationID: UUID?) {
            self.path = "\(basePath)/\(productID)/increments"
            if let locationID {
                self.urlQueryParams["locationID"] = "\(locationID)"
            }
        }
    }
    
    /// Read a single inventory increment for a product.
    /// Returns more information about the specific increment than a ReadAllRequest
    struct ReadRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .GET
        public var response: Decodable.Type? = nil
        public var body: Encodable? = nil
        
        public init(productID: UUID, incrementID: Int) {
            self.path = "\(basePath)/\(productID)/increments/\(incrementID)"
        }
    }
    
    /// Update an existing increment for a product.
    /// Only adjustments can be updated or changed via this endpoint.
    /// If a serial number is provided at all the amount must be `-1`, `0`, or `1`
    struct UpdateRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String]
        public var requestType: MWRequest_HTTPType = .POST
        public var response: Decodable.Type? = nil
        public var body: Encodable? = nil
        
        public init(
            productID: UUID,
            locationID: UUID,
            incrementID: Int,
            amount: Int,
            serialNumber: String?
        ) throws {
            self.path = "\(basePath)/\(productID)/increments/\(incrementID)"
            self.urlQueryParams = [
                "locationID": "\(locationID)",
                "amount": "\(amount)"
            ]
            if let serialNumber {
                guard amount == 0 ||
                        amount == -1 ||
                        amount == 1
                else {
                    throw IncrementDTOError.invalidAmount
                }
                self.urlQueryParams["amount"] = "\(amount)"
                self.urlQueryParams["serialNumber"] = serialNumber
            }
        }
    }
    
    // TODO: Implement DeleteRequest
    struct DeleteRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .DELETE
        public var response: Decodable.Type? = nil
        public var body: Encodable? = nil
        
        public init(productID: UUID, incrementID: Int) {
            self.path = "\(basePath)/\(productID)/increments/\(incrementID)"
        }
    }
    
    /// Throw an error for issues with request object creation
    public enum IncrementDTOError: Error {
        case invalidAmount
    }
}
