import Foundation

/// Models used to represent a Base: Document container for customers, line items, payments, status
public struct Base_DTO {
    public enum V1 {
        /// The master  `Base` model
        public struct Document {}
    }
}

fileprivate typealias Document = Base_DTO.V1.Document

extension Document {
    
    /// Base model
    public struct Model: Codable, Identifiable, Hashable {
        // MARK: Identifiers
        public var id: Int
        
        public var createdAt: Date
        public var updatedAt: Date?
        public var deletedAt: Date?
        
        // MARK: Currency/Tax Information
        public var currency: Currency_DTO.V1.Model
        public var tax: Tax_DTO.V1.Model
        
        // MARK: Contact Information
        public var contactInformation: DocumentContactInformation.Model
        
        // MARK: Totals
        public var subtotal: Decimal
        public var total_discountt: Decimal
        public var total_cost: Decimal
        public var total_profit: Decimal
        public var total_tax: Decimal
        public var total: Decimal
        
        // MARK: Line Items
        public var line_items: [Base_DTO.V1.LineItem.Model]
        
        
        public init(
            id: Int,
            createdAt: Date, updatedAt: Date? = nil, deletedAt: Date? = nil,
            currency: Currency_DTO.V1.Model,
            tax: Tax_DTO.V1.Model,
            contactInformation: DocumentContactInformation.Model,
            subtotal: Decimal, total_discountt: Decimal,
            total_cost: Decimal, total_profit: Decimal, 
            total_tax: Decimal, total: Decimal,
            line_items: [Base_DTO.V1.LineItem.Model]
        ) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.deletedAt = deletedAt
            self.currency = currency
            self.tax = tax
            self.contactInformation = contactInformation
            self.subtotal = subtotal
            self.total_discountt = total_discountt
            self.total_cost = total_cost
            self.total_profit = total_profit
            self.total_tax = total_tax
            self.total = total
            self.line_items = line_items
        }
    }
    
    /// When creating a `ServiceOrder`, `Quote`, or `Invoice`, this is submitted to contain the `LineItems` and `Currency`/`Tax` information
    public struct CreateRequestModel: Codable {
        
        /// Who is assigned to this document
        public var assignedUserID: UUID?
        
        /// Is there a `Currency` assigned to this `Base` that's not the default?
        public var currencyID: UUID?
        
        /// Is there a `Tax` assigned to this `Base` that's not the default?
        public var taxID: UUID?
        
        /// Contact information for this document
        public var contactInformation: DocumentContactInformation.CreateRequestModel
        
        /// The `LineItem`s to create at the server with the `Base` model
        public var line_items: [Base_DTO.V1.LineItem.CreateRequestModel]
    }
}
