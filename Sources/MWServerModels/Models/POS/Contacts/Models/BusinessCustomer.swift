import Foundation

// MARK: - Business Customers
public struct BusinessCustomer_DTO {
    //public enum V1 {}
    public enum V2 {}
}

// MARK: - V2
extension BusinessCustomer_DTO.V2: MWDTO_CRUDModel {
    static public var path: String = "customers/businesses"
    
    /// The model returned from server
    public struct Model: Codable, Identifiable, Hashable, ModelDateProtocol {
        public var id: UUID
        public var createdAt: Date
        public var updatedAt: Date
        
        /// The name of this business
        public var businessName: String
        /// Optional default tax to use with this business
        public var defaultTax: Tax_DTO.V1.Model?
        
        /// Customer models with this optional parent
        public var customers: [Customer_DTO.V2.Model]
        
        public init(
            id: UUID, createdAt: Date, updatedAt: Date,
            businessName: String, defaultTax: Tax_DTO.V1.Model? = nil,
            customers: [Customer_DTO.V2.Model] = []
        ) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.businessName = businessName
            self.defaultTax = defaultTax
            self.customers = customers
        }
        
        public static func < (lhs: BusinessCustomer_DTO.V2.Model, rhs: BusinessCustomer_DTO.V2.Model) -> Bool {
            return lhs.id == rhs.id
        }
        public static func == (lhs: BusinessCustomer_DTO.V2.Model, rhs: BusinessCustomer_DTO.V2.Model) -> Bool {
            return lhs.id == rhs.id
        }
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    /// Create/Update request Body
    public struct CreateRequestModel: Codable {
        public var businessName: String
        public var defaultTax: UUID?
        
        public init(businessName: String, defaultTax: UUID? = nil) {
            self.businessName = businessName
            self.defaultTax = defaultTax
        }
    }
    //public typealias GetAllModel = BusinessCustomer_DTO.V1.Model
    public typealias UpdateRequestModel = CreateRequestModel
}

// MARK: GetAll Request
extension BusinessCustomer_DTO.V2 {
    /// Return a list of all `BusinessCustomer_DTO.V2.Model` at the server
    public struct GetAllRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .GET
        public var response: Decodable.Type? = nil
        public var body: Encodable? = nil
        
        public init() {
            self.path = "\(BusinessCustomer_DTO.V2.path)/all"
        }
    }
}
