import Foundation

public struct ProductCost_DTO {
    public enum V1 {}
}

fileprivate typealias V1 = ProductCost_DTO.V1

extension V1 {
    /// The minimum model for overview in other models
    /// Product model, purchase order model choice
    public struct minModel: Codable {
        public var defaultCost: Bool
        public var cost: Decimal
        public var supplierCode: String
        
        public init(defaultCost: Bool, cost: Decimal, supplierCode: String) {
            self.defaultCost = defaultCost
            self.cost = cost
            self.supplierCode = supplierCode
        }
    }
    
    /// The model returned from the server
    public struct Model: ModelDateProtocol, Codable, Identifiable {
        public var id: UUID
        // MARK: ModelDateProtocol
        public var createdAt: Date
        public var updatedAt: Date
        
        // MARK: Model
        public var supplierID: Supplier_DTO.V1.Model?
        public var defaultCost: Bool
        public var cost: Decimal
        public var supplierCode: String
        
        public init(id: UUID,
                    createdAt: Date, updatedAt: Date, supplierID: Supplier_DTO.V1.Model? = nil,
                    defaultCost: Bool, cost: Decimal, supplierCode: String) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.supplierID = supplierID
            self.defaultCost = defaultCost
            self.cost = cost
            self.supplierCode = supplierCode
        }
    }
    
    /// POST/PUT request model
    public struct CreateUpdateRequest: Codable {
        
        // MARK: Model
        public var supplierID: Int?
        public var defaultCost: Bool
        public var cost: Decimal
        public var supplierCode: String
        
        public init(supplierID: Int? = nil,
                    defaultCost: Bool, cost: Decimal, supplierCode: String) {
            self.supplierID = supplierID
            self.defaultCost = defaultCost
            self.cost = cost
            self.supplierCode = supplierCode
        }
    }
}


// MARK: Get All Costs for Product Request
extension V1 {
    /// Get all the product costs for a `Product`
    public struct GetProductCost: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .GET
        public var response: Decodable.Type? = [ProductCost_DTO.V1.Model].self
        public var body: Encodable? = nil
        
        public init (productID: Int) {
            self.path = "products/\(productID)/costs"
        }
    }
}

// MARK: Get Single Cost for Product
extension V1 {
    /// Get a single product cost for a `Product`
    public struct GetSingleProductCost: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .GET
        public var response: Decodable.Type? = ProductCost_DTO.V1.Model.self
        public var body: Encodable? = nil
        
        public init (productID: Int, costID: UUID) {
            self.path = "products/\(productID)/costs/\(costID)"
        }
    }
}

// MARK: Create Cost for Product
extension V1 {
    /// Create a new product cost for a `Product`
    public struct CreateProductCost: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .POST
        public var response: Decodable.Type? = ProductCost_DTO.V1.Model.self
        public var body: Encodable?
        
        public init (productID: Int, body: ProductCost_DTO.V1.CreateUpdateRequest) {
            self.path = "products/\(productID)/costs"
            self.body = body
        }
    }
}

// MARK: Update Cost for Product
extension V1 {
    /// Update a product cost for a `Product`
    public struct UpdateProductCost: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .PUT
        public var response: Decodable.Type? = ProductCost_DTO.V1.Model.self
        public var body: Encodable?
        
        public init (productID: Int, costID: UUID, body: ProductCost_DTO.V1.CreateUpdateRequest) {
            self.path = "products/\(productID)/costs/\(costID)"
            self.body = body
        }
    }
}

// MARK: Delete Cost for Product
extension V1 {
    /// Delete a product cost for a `Product`
    public struct DeleteProductCost: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .DELETE
        public var response: Decodable.Type? = ProductCost_DTO.V1.Model.self
        public var body: Encodable? = nil
        
        public init (productID: Int, costID: UUID) {
            self.path = "products/\(productID)/costs/\(costID)"
        }
    }
}


