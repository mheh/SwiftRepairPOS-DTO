import Foundation

// MARK: - Taxes
/// Send and receive `Tax` models
public struct Tax_DTO: Codable {
    public enum V1 {}
}

fileprivate typealias V1 = Tax_DTO.V1

extension V1 {
    /// Tax model from server
    public struct Model: Codable, Identifiable {
        /// Unique ID from server
        public var id: UUID
        /// Date the tax was created at
        public var createdAt: Date
        /// Date the tax was updated at
        public var updatedAt: Date
        
        /// The `Currency` this Tax is associated with
        public var currency: Currency_DTO.V1.Model
        /// Tax Code
        /// `US-TX
        public var taxCode: String
        /// Rate of taxation. 4 DECIMAL PRECISION
        /// `0.0825`
        public var taxRate: Decimal
        /// Make this the default tax for documents
        public var defaultTax: Bool
        /// Is this tax removable?
        public var removable: Bool
        
        
        public init(id: UUID, createdAt: Date, updatedAt: Date, 
                    currency: Currency_DTO.V1.Model,
                    taxCode: String, taxRate: Decimal, defaultTax: Bool, removable: Bool) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.currency = currency
            self.taxCode = taxCode
            self.taxRate = taxRate
            self.defaultTax = defaultTax
            self.removable = removable
        }
    }
    
    
    /// Create a new `Tax` model at the server
    /// Requires a `Currency ID`
    public struct CreateRequestModel: Codable {
        public var currencyID: UUID
        public var taxCode: String
        public var taxRate: Decimal
        public var defaultTax: Bool
        
        public init(currencyID: UUID, taxCode: String, taxRate: Decimal, defaultTax: Bool) {
            self.currencyID = currencyID
            self.taxCode = taxCode
            self.taxRate = taxRate
            self.defaultTax = defaultTax
        }
    }
}

// MARK: - Hashable Conformance
extension V1.Model: Hashable {
    public static func == (lhs: Tax_DTO.V1.Model, rhs: Tax_DTO.V1.Model) -> Bool {
        return lhs.id == rhs.id
        && lhs.createdAt == rhs.createdAt
        && lhs.updatedAt == rhs.updatedAt
        && lhs.taxCode == rhs.taxCode
        && lhs.taxRate == rhs.taxRate
        && lhs.defaultTax == rhs.defaultTax
        && lhs.removable == rhs.removable
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(createdAt)
        hasher.combine(updatedAt)
        hasher.combine(taxCode)
        hasher.combine(taxRate)
        hasher.combine(defaultTax)
        hasher.combine(removable)
    }
}

// MARK: - MWRequestProtocol

// MARK: CreateRequest
extension V1 {
    /// Create a new tax
    public struct CreateRequest: MWRequestProtocol {
        public var path: String = "server_settings/taxes"
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .POST
        public var response: Decodable.Type? = nil
        public var body: Encodable?

        public init(body: CreateRequestModel) {
            self.body = body
        }
    }
}

// MARK: GetAll Request
extension V1 {
    /// Get all taxes
    public struct GetAllRequest: MWRequestProtocol {
        public var path: String = "server_settings/taxes"
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .GET
        public var response: Decodable.Type? = nil
        public var body: Encodable? = nil
        
        public init() {}
    }
}

// MARK: GetSingle Request
extension V1 {
    /// Read a single Tax
    public struct GetSingleRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .GET
        public var response: Decodable.Type? = nil
        public var body: Encodable? = nil
    
        public init(id: UUID) {
            self.path = "server_settings/taxes/\(id)"
        }
    }
}

// MARK: UpdateRequest
extension V1 {
    /// Update a Tax
    public struct UpdateRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .PUT
        public var response: Decodable.Type? = nil
        public var body: Encodable?
    
        public init(id: UUID, body: CreateRequestModel) {
            self.path = "server_settings/taxes/\(id)"
            self.body = body
        }
    }
}

// MARK: DeleteRequest
extension V1 {
    /// Delete a Tax
    public struct DeleteRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .DELETE
        public var response: Decodable.Type? = nil
        public var body: Encodable? = nil

        public init(id: UUID) {
            self.path = "server_settings/taxes/\(id)"
        }
    }
}
