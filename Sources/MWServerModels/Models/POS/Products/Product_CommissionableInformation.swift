import Foundation

public struct ProductCommissionableInfo_DTO {
    public enum V1 {}
}

extension ProductCommissionableInfo_DTO.V1 {
    public static var path: String = "products"
    
    /// The model returned from the server
    public struct Model: Codable, Identifiable {
        public var id: UUID
        
        // MARK: ModelDateProtocol
        public var createdAt: Date
        public var updatedAt: Date
        
        // MARK: Model
        public var title: String
        public var commDescription: String
        
        public var commissionType: CommissionType_DTO
        public var amount: Decimal
        
        public init(id: UUID, createdAt: Date, updatedAt: Date, title: String, commDescription: String, commissionType: CommissionType_DTO, amount: Decimal) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.title = title
            self.commDescription = commDescription
            self.commissionType = commissionType
            self.amount = amount
        }
    }
    
    /// Create a new model at the server
    public struct CreateRequestModel: Codable {
        public var title: String
        public var commDescription: String
        
        public var commissionType: CommissionType_DTO
        public var amount: Decimal
        
        public init(title: String, commDescription: String, commissionType: CommissionType_DTO, amount: Decimal) {
            self.title = title
            self.commDescription = commDescription
            self.commissionType = commissionType
            self.amount = amount
        }
    }
    
    /// Update an existing model at the server
    public struct UpdateRequestModel: Codable {
        public var title: String?
        public var commDescription: String?
        
        public var commissionType: CommissionType_DTO?
        public var amount: Decimal?
        
        public init(title: String? = nil, commDescription: String? = nil, commissionType: CommissionType_DTO? = nil, amount: Decimal? = nil) {
            self.title = title
            self.commDescription = commDescription
            self.commissionType = commissionType
            self.amount = amount
        }
    }
    
    /// What type of commission is available for this sale?
    public enum CommissionType_DTO: String, Codable {
        /// A set amount for each sale
        case flatAmount
        /// A percentage based off the sell price
        case percentageSell
        /// A percentage based off the margin available
        case percentageMargin
    }
}

// MARK: Request
extension ProductCommissionableInfo_DTO.V1 {
    /// Createa a new commissionable model for this product
    public struct CreateRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .POST
        public var body: Encodable?
        public var response: Decodable.Type? = nil
        
        public init(productID: UUID, body: CreateRequestModel) {
            self.path = "products/\(productID)/commissions"
            self.body = body
        }
    }
    
    /// Read all the commissions
    public struct ReadAllRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .GET
        public var body: Encodable? = nil
        public var response: Decodable.Type? = nil
        
        /// Read all commissions for the provided product ID
        public init(productID: UUID) {
            self.path = "products/\(productID)/commissions"
        }
        
        /// Read all the commissions for every product
        public init() {
            self.path = "products/commissions"
        }
    }
    
    /// Read about a single commission
    public struct ReadRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .GET
        public var body: Encodable? = nil
        public var response: Decodable.Type? = nil
        
        public init(productID: UUID, commissionID: UUID) {
            self.path = "products/\(productID)/commissions/\(commissionID)"
        }
    }
    
    /// Update a commission model at the server
    public struct UpdateRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .PUT
        public var body: Encodable?
        public var response: Decodable.Type? = nil
        
        public init(productID: UUID, commissionID: UUID, body: UpdateRequestModel) {
            self.path = "products/\(productID)/commissions/\(commissionID)"
            self.body = body
        }
    }
}
