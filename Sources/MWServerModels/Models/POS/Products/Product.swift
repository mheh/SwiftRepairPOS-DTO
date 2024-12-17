import Foundation

public struct Product_DTO {
    public enum V1 {}
}
 
extension Product_DTO.V1: MWDTO_CRUDModel {
    public static var path: String = "products"
    
    /// Model returned from server
    public struct Model: Codable, Identifiable, Hashable {
        public var id: Int
        
        // MARK: ModelDateProtocol
        public var createdAt: Date
        public var updatedAt: Date
        
        public var code: String
        public var upc: String
        public var productDescription: String
        
        public var sellPrice: Decimal
        
        public var taxable: Bool
        public var inventoried: Bool
        public var serialized: Bool
        
        public var lightspeedImportID: Int?
        
        public var manufacturer: String
        public var manufacturerType: String
        public var manufacturerModel: String
        
        public init(id: Int, createdAt: Date, updatedAt: Date,
                    code: String, upc: String, productDescription: String,
                    sellPrice: Decimal, taxable: Bool, inventoried: Bool, serialized: Bool,
                    lightspeedImportID: Int?,
                    manufacturer: String, manufacturerType: String, manufacturerModel: String) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.code = code
            self.upc = upc
            self.productDescription = productDescription
            self.sellPrice = sellPrice
            self.taxable = taxable
            self.inventoried = inventoried
            self.serialized = serialized
            self.lightspeedImportID = lightspeedImportID
            self.manufacturer = manufacturer
            self.manufacturerType = manufacturerType
            self.manufacturerModel = manufacturerModel
        }
    }
    
    /// Create request model
    public struct CreateRequestModel: Codable {
        public var code: String
        public var upc: String
        public var productDescription: String
        
        public var sellPrice: Decimal
        public var taxable: Bool
        
        public var inventoried: Bool
        public var serialized: Bool
        
        public var manufacturer: String
        public var manufacturerType: String
        public var manufacturerModel: String
        
        public init(code: String, upc: String, productDescription: String, sellPrice: Decimal, taxable: Bool, inventoried: Bool, serialized: Bool, manufacturer: String, manufacturerType: String, manufacturerModel: String) {
            self.code = code
            self.upc = upc
            self.productDescription = productDescription
            self.sellPrice = sellPrice
            self.taxable = taxable
            self.inventoried = inventoried
            self.serialized = serialized
            self.manufacturer = manufacturer
            self.manufacturerType = manufacturerType
            self.manufacturerModel = manufacturerModel
        }
    }
    
    /// Update Request Model
    /// non-nil values iwll be updated
    public struct UpdateRequestModel: Codable {
        public var code: String?
        public var upc: String?
        public var productDescription: String?
        
        public var sellPrice: Decimal?
        public var taxable: Bool?
        
        public var inventoried: Bool?
        public var serialized: Bool?
        
        public var manufacturer: String?
        public var manufacturerType: String?
        public var manufacturerModel: String?
        
        public init(
            code: String? = nil,
            upc: String? = nil,
            productDescription: String? = nil,
            sellPrice: Decimal? = nil,
            taxable: Bool? = nil,
            inventoried: Bool? = nil,
            serialized: Bool? = nil,
            manufacturer: String? = nil,
            manufacturerType: String? = nil,
            manufacturerModel: String? = nil
        ) {
            self.code = code
            self.upc = upc
            self.productDescription = productDescription
            self.sellPrice = sellPrice
            self.taxable = taxable
            self.inventoried = inventoried
            self.serialized = serialized
            self.manufacturer = manufacturer
            self.manufacturerType = manufacturerType
            self.manufacturerModel = manufacturerModel
        }
    }
}
