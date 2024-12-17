import Foundation

// MARK: - LineItem_DTO
/// Send and receive `LineItem` models form the server
extension Base_DTO.V1 {
    public struct LineItem {}
}

fileprivate typealias LineItem = Base_DTO.V1.LineItem

extension LineItem {
    public struct Model: Codable, Identifiable, Hashable {
        /// LineItem ID
        public var id: Int
        
        
        
        // MARK: Descriptors
        /// The description of this line item, presented on a receipt
        public var lineDescription: String
        
        /// The order in which to place a line item
        public var lineOrder: Int
        
        /// The product associated with this line item
        public var product: Product_DTO.V1.Model
        
        /// Whether the description is editable by the user receiving this line
        public var editableDescription: Bool
        
        /// Whether the sell price is editable by the user receiving this linet
        public var editableSellPrice: Bool
        
        /// Whether this line item is serialized
        public var serialized: Bool
        
        /// Serial numbers associated with this line item
        public var serialNumbers: [String]
        
        
        
        // MARK: Units
        /// The quantity for this line item
        public var quantity: Decimal
        
        /// The sell price per quantity
        public var unit_sellPrice: String
        
        /// Whether the discount amount is interpreted as a whole number or percentage
        public var unit_discountIsPercentage: Bool
        
        /// The amount to discount each unit
        public var unit_discountAmount: String
        
        /// The amount of tax per unit
        public var unit_taxAmount: String
        
        
        
        // MARK: Totals
        /// The subtotal for this line item, including discount
        public var subtotal: String
        
        /// The total discount amount for this line item
        public var total_discount: String
        
        /// The total tax amount for this line item
        public var total_tax: String
        
        /// The total for this line item, including discounts and tax
        public var total: String
        
        public init(
            id: Int, 
            lineDescription: String, 
            lineOrder: Int,
            product: Product_DTO.V1.Model,
            editableDescription: Bool, 
            editableSellPrice: Bool,
            serialized: Bool,
            serialNumbers: [String],
            quantity: Decimal,
            unit_sellPrice: String,
            unit_discountIsPercentage: Bool,
            unit_discountAmount: String, 
            unit_taxAmount: String,
            subtotal: String,
            total_discount: String, total_tax: String, total: String
        ) {
            self.id = id
            self.lineDescription = lineDescription
            self.lineOrder = lineOrder
            self.product = product
            self.editableDescription = editableDescription
            self.editableSellPrice = editableSellPrice
            self.serialized = serialized
            self.serialNumbers = serialNumbers
            self.quantity = quantity
            self.unit_sellPrice = unit_sellPrice
            self.unit_discountIsPercentage = unit_discountIsPercentage
            self.unit_discountAmount = unit_discountAmount
            self.unit_taxAmount = unit_taxAmount
            self.subtotal = subtotal
            self.total_discount = total_discount
            self.total_tax = total_tax
            self.total = total
        }
    }
    
    
    
    
    
    
    /// The full `LineItem` model when an `Admin` requests more information about a line item
    public struct FullModel: Codable, Identifiable, Hashable {
        
        /// @ID(custom: LineItem.V1.id)                                         var id: Int?
        public var id: Int
        
        
        // MARK: DateTracking Protocol
        
        /// @Timestamp(key:         LineItem.V1.createdAt, on: .create)         var createdAt: Date?
        public var createdAt: Date
        
        /// @Timestamp(key:         LineItem.V1.updatedAt, on: .update)         var updatedAt: Date?
        public var updatedAt: Date?
        
        /// @Timestamp(key:         LineItem.V1.deletedAt, on: .delete)         var deletedAt: Date?
        public var deletedAt: Date?
        
        
        // MARK: User Tracking
        /// Tracking for user interaction
        public var userTracking: String?
        
        
        // MARK: Line Descriptors
        /// The printed description of the line item
        public var lineDescription: String
        
        /// The order of the line item
        public var lineOrder: Int
        
        /// The serial numbers associated with this `LineItem`
        public var serialNumbers: [String]
        
        
        // MARK: - MonetaryLineItemFields Protocol
        /// The product on this line item
        public var productID: Product_DTO.V1.Model?
        
        /// The taxID for this line item
        public var taxID: Tax_DTO.V1.Model?
        
        
        // MARK: Reference Fields
        /// @Field(key: LineItem.V1.reference_productCode)                      var reference_productCode: String
        public var reference_productCode: String
        /// @Field(key: LineItem.V1.reference_productDescription)               var reference_productDescription: String
        public var reference_productDescription: String
        /// @Field(key: LineItem.V1.reference_productSellPrice)                 var reference_productSellPrice: Decimal
        public var reference_productSellPrice: String
        /// @Field(key: LineItem.V1.reference_productCost)                      var reference_productCost: Decimal
        public var reference_productCost: String
        /// @Field(key: LineItem.V1.reference_productSerialized)                var reference_productSerialized: Bool
        public var reference_productSerialized: Bool
        /// @Field(key: LineItem.V1.reference_productCommissionable)            var reference_productCommissionable: Bool
        public var reference_productCommissionable: Bool
        /// @Field(key: LineItem.V1.reference_productEditableSellPrice)         var reference_productEditableSellPrice: Bool
        public var reference_productEditableSellPrice: Bool
        
        
        /// @Field(key: LineItem.V1.reference_taxRate)                          var reference_taxRate: Decimal
        public var reference_taxRate: String
        
        /// @Field(key: LineItem.V1.reference_taxCode)                          var reference_taxCode: String
        public var reference_taxCode: String
        
        /// //// Quantity of this line item. Two-decimal precision `NUMERIC(19,2)`
        /// @Field(key: LineItem.V1.quantity)                                   var quantity: Decimal
        public var quantity: String
        
        /// @Field(key: LineItem.V1.unit_sellPrice)                             var unit_sellPrice: Decimal
        public var unit_sellPrice: String
        /// @Field(key: LineItem.V1.unit_sellPrice_DiscountAmount)              var unit_sellPrice_DiscountAmount: Decimal
        public var unit_sellPrice_DiscountAmount: String
        /// @Field(key: LineItem.V1.unit_sellPrice_Total)                       var unit_sellPrice_Total: Decimal
        public var unit_sellPrice_Total: String
        
        /// @Field(key: LineItem.V1.unit_discountIsPercentage)                  var unit_discountIsPercentage: Bool
        public var unit_discountIsPercentage: Bool
        /// @Field(key: LineItem.V1.unit_discountAmount)                        var unit_discountAmount: Decimal
        public var unit_discountAmount: String
        
        /// @Field(key: LineItem.V1.unit_taxAmount)                             var unit_taxAmount: Decimal
        public var unit_taxAmount: String
        /// @Field(key: LineItem.V1.unit_profitMargin)                          var unit_profitMargin: Decimal
        public var unit_profitMargin: String
        
        /// @Field(key: LineItem.V1.total_subTotal)                             var total_subTotal: Decimal
        public var total_subTotal: String
        /// @Field(key: LineItem.V1.total_discountAmount)                       var total_discountAmount: Decimal
        public var total_discountAmount: String
        /// @Field(key: LineItem.V1.total_costTotal)                            var total_costTotal: Decimal
        public var total_costTotal: String
        /// @Field(key: LineItem.V1.total_profitMarginTotal)                    var total_profitMarginTotal: Decimal
        public var total_profitMarginTotal: String
        /// @Field(key: LineItem.V1.total_taxAmount)                            var total_taxAmount: Decimal
        public var total_taxAmount: String
        
        /// The total of the line item. With Discounts, Tax Amount applied.
        /// @Field(key: LineItem.V1.total)                                      var total: Decimal
        public var total: String
        
        
        // MARK: - Logs
        public var logs: String?
        
        public init(
            id: Int, createdAt: Date, updatedAt: Date? = nil, deletedAt: Date? = nil,
            
            userTracking: String? = nil,
            
            lineDescription: String, 
            lineOrder: Int,
            serialNumbers: [String],
            productID: Product_DTO.V1.Model? = nil, taxID: Tax_DTO.V1.Model? = nil,
            
            reference_productCode: String,
            reference_productDescription: String,
            reference_productSellPrice: String,
            reference_productCost: String,
            reference_productSerialized: Bool,
            reference_productCommissionable: Bool,
            reference_productEditableSellPrice: Bool,
            reference_taxRate: String,
            reference_taxCode: String,
            
            quantity: String,
            
            unit_sellPrice: String,
            unit_sellPrice_DiscountAmount: String,
            unit_sellPrice_Total: String,
            unit_discountIsPercentage: Bool,
            unit_discountAmount: String,
            unit_taxAmount: String,
            unit_profitMargin: String,
            
            total_subTotal: String,
            total_discountAmount: String,
            total_costTotal: String,
            total_profitMarginTotal: String,
            total_taxAmount: String,
            total: String,
            
            logs: String? = nil
        ) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.deletedAt = deletedAt
            self.userTracking = userTracking
            self.lineDescription = lineDescription
            self.lineOrder = lineOrder
            self.serialNumbers = serialNumbers
            self.productID = productID
            self.taxID = taxID
            self.reference_productCode = reference_productCode
            self.reference_productDescription = reference_productDescription
            self.reference_productSellPrice = reference_productSellPrice
            self.reference_productCost = reference_productCost
            self.reference_productSerialized = reference_productSerialized
            self.reference_productCommissionable = reference_productCommissionable
            self.reference_productEditableSellPrice = reference_productEditableSellPrice
            self.reference_taxRate = reference_taxRate
            self.reference_taxCode = reference_taxCode
            self.quantity = quantity
            self.unit_sellPrice = unit_sellPrice
            self.unit_sellPrice_DiscountAmount = unit_sellPrice_DiscountAmount
            self.unit_sellPrice_Total = unit_sellPrice_Total
            self.unit_discountIsPercentage = unit_discountIsPercentage
            self.unit_discountAmount = unit_discountAmount
            self.unit_taxAmount = unit_taxAmount
            self.unit_profitMargin = unit_profitMargin
            self.total_subTotal = total_subTotal
            self.total_discountAmount = total_discountAmount
            self.total_costTotal = total_costTotal
            self.total_profitMarginTotal = total_profitMarginTotal
            self.total_taxAmount = total_taxAmount
            self.total = total
            self.logs = logs
        }
        
    }
    
    /// When creating a new document with a `Base` model attached, this is used to create a `LineItem`
    public struct CreateRequestModel: Codable {
        
        
        /// Editable `product.productDescription`
        public var lineDescription: String
        
        /// The order this `LineItem` appears in the list
        public var lineOrder: Int
    
        
        /// The `Product.id` for this `LineItem`
        public var productID: Int
        
        /// The quantity
        public var quantity: Decimal
        
        /// Serial numbers for this line item.
        public var serialNumbers: [String]
        
        /// The `SellPrice` per quantity
        public var unit_sellPrice: Decimal
        
        /// Type of discount
        public var unit_discountIsPercentage: Bool
        
        /// The amount to discount `unit_sellPrice` by/
        /// `unit_sellPrice = 20`, `unit_discountAmount = 5`, `unit_discountIsPercentage = false`, `subtotal = 15`
        public var unit_discountAmount: Decimal
        
        
        public init(
            lineDescription: String, 
            lineOrder: Int, productID: Int, 
            quantity: Decimal,
            serialNumbers: [String],
            unit_sellPrice: Decimal,
            unit_discountIsPercentage: Bool,
            unit_discountAmount: Decimal
        ) {
            self.lineDescription = lineDescription
            self.lineOrder = lineOrder
            self.productID = productID
            self.quantity = quantity
            self.serialNumbers = serialNumbers
            self.unit_sellPrice = unit_sellPrice
            self.unit_discountIsPercentage = unit_discountIsPercentage
            self.unit_discountAmount = unit_discountAmount
        }
    }
}
