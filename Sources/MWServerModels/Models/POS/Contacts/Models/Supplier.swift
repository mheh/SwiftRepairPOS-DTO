import Foundation

// MARK: - Model
public struct Supplier_DTO {
    public enum V1 {}
    
}

// MARK: V1 
private typealias V1 = Supplier_DTO.V1
extension V1: MWDTO_CRUDModel {
    static public var path: String = "suppliers"
    
    /// The model returned from the server
    public struct Model: Codable, Identifiable, Hashable, PrimaryContactLookupProtocol {
        public var id: Int
        public var createdAt: Date
        public var updatedAt: Date
        
        /// Supplier company name
        public var supplierName: String
        /// Supplier first name
        public var firstName: String
        /// Supplier last name
        public var lastName: String
        /// Computed full name
        public var fullName: String { return "\(firstName) \(lastName)" }
        
        /// Supplier website
        public var homepage: String
        
        
        /// Phone numbers associated with this supplier
        public var phones: [PhoneNumber_DTO.V1.Model]
        /// Email addresses associated with this supplier
        public var emails: [EmailAddress_DTO.V1.Model]
        /// Street addresses associated with this supplier
        public var addresses: [StreetAddress_DTO.V1.Model]
        
        
        /// Optional default tax to use with this Supplier
        public var defaultTax: Tax_DTO.V1.Model?
        /// Optional lightspeed import ID
        public var lightspeedImportID: Int?
        
        public init (
            id: Int, 
            createdAt: Date, 
            updatedAt: Date, 
            supplierName: String, 
            firstName: String, 
            lastName: String,
            homepage: String,
            phoneNumbers: [PhoneNumber_DTO.V1.Model],
            emailAddresses: [EmailAddress_DTO.V1.Model],
            streetAddresses: [StreetAddress_DTO.V1.Model],
            defaultTax: Tax_DTO.V1.Model?,
            lightspeedImportID: Int?
        ) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.supplierName = supplierName
            self.firstName = firstName
            self.lastName = lastName
            self.homepage = homepage
            self.phones = phoneNumbers
            self.emails = emailAddresses
            self.addresses = streetAddresses
            self.defaultTax = defaultTax
            self.lightspeedImportID = lightspeedImportID
        }
    }
    
    
    /// Create a new `Supplier`
    public struct CreateRequestModel: Codable {
        /// Supplier name
        /// `Apple, Inc.`
        public var supplierName: String
        /// Supplier first name
        /// `Tim`
        public var firstName: String
        /// Supplier last name
        /// `Cook`
        public var lastName: String
        
        /// Homepage of supplier
        public var homepage: String
        
        /// Assign a default tax to this supplier
        public var defaultTax: UUID?
        
        /// Phone numbers
        public var phoneNumbers: [PhoneNumber_DTO.V1.CreateRequest]
        /// Email addresses
        public var emailAddresses: [EmailAddress_DTO.V1.CreateRequest]
        /// Street addresses
        public var streetAddresses: [StreetAddress_DTO.V1.CreateRequest]
        
        public init (
            supplierName: String, 
            firstName: String, 
            lastName: String,
            homepage: String,
            defaultTax: UUID?,
            phoneNumbers: [PhoneNumber_DTO.V1.CreateRequest],
            emailAddresses: [EmailAddress_DTO.V1.CreateRequest],
            streetAddresses: [StreetAddress_DTO.V1.CreateRequest]
        ) {
            self.supplierName = supplierName
            self.firstName = firstName
            self.lastName = lastName
            self.homepage = homepage
            self.defaultTax = defaultTax
            self.phoneNumbers = phoneNumbers
            self.emailAddresses = emailAddresses
            self.streetAddresses = streetAddresses
        }
    }
    
    /// non-nil values will be updated
    public struct UpdateRequestModel: Codable {
        /// Supplier name
        /// `Apple, Inc.`
        public var supplierName: String?
        /// Supplier first name
        /// `Tim`
        public var firstName: String?
        /// Supplier last name
        /// `Cook`
        public var lastName: String?
        
        /// Homepage of supplier
        public var homepage: String?
        
        /// Assign a default tax to this supplier
        public var defaultTax: UUID?
        /// Assign this value and it will remove the default tax
        public var removeDefaultTax: Bool?
        
        /// Phone numbers
        public var updatedPhones: [PhoneNumber_DTO.V1.UpdateRequest]?
        /// Email addresses
        public var updatedEmails: [EmailAddress_DTO.V1.UpdateRequest]?
        /// Street addresses
        public var updatedStreets: [StreetAddress_DTO.V1.UpdateRequest]?
        
        /// New phone numbers to add
        public var newPhones: [PhoneNumber_DTO.V1.CreateRequest]?
        /// New email addresses to add
        public var newEmails: [EmailAddress_DTO.V1.CreateRequest]?
        /// New street addresses to add
        public var newStreets: [StreetAddress_DTO.V1.CreateRequest]?
        
        public init (
            supplierName: String?, 
            firstName: String?, 
            lastName: String?,
            homepage: String?,
            defaultTax: UUID?,
            removeDefaultTax: Bool? = nil,
            updatedPhones: [PhoneNumber_DTO.V1.UpdateRequest]? = nil, updatedEmails: [EmailAddress_DTO.V1.UpdateRequest]? = nil, updatedStreets: [StreetAddress_DTO.V1.UpdateRequest]? = nil,
            newPhones: [PhoneNumber_DTO.V1.CreateRequest]?, newEmails: [EmailAddress_DTO.V1.CreateRequest]?, newStreets: [StreetAddress_DTO.V1.CreateRequest]?
        ) {
            self.supplierName = supplierName
            self.firstName = firstName
            self.lastName = lastName
            self.homepage = homepage
            self.defaultTax = defaultTax
            self.removeDefaultTax = removeDefaultTax
            self.updatedPhones = updatedPhones
            self.updatedEmails = updatedEmails
            self.updatedStreets = updatedStreets
            self.newPhones = newPhones
            self.newEmails = newEmails
            self.newStreets = newStreets
        }
    }
}
