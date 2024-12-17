import Foundation
import PhoneNumberKit

// MARK: - Model
public struct Customer_DTO {
    //public enum V1 {}
    public enum V2 {}
}

// MARK: - V2
extension Customer_DTO.V2: MWDTO_CRUDModel {
    static public var path: String = "customers"
    
    /// The ModelFields for a `Customer_DTO` model
    public enum ModelFields: String, Codable, CaseIterable {
        case id = "ID"
        case createdAt = "Created At"
        case updatedAt = "Updated At"
        case firstName = "First Name"
        case lastName = "Last name"
        case businessCustomer = "Business Customer"
        
    }
    
    /// The model returned from the server
    public struct Model: Codable, Identifiable, Hashable, PrimaryContactLookupProtocol {
        public var id: Int
        public var createdAt: Date?
        public var updatedAt: Date?
        
        /// Customer first name
        public var firstName: String
        /// Customer last name
        public var lastName: String
        /// Computed full name
        public var fullName: String { return "\(self.firstName) \(self.lastName)"}
        /// Name of Business associated with this customer
        public var businessCustomer: String?
        
        /// Customer website
        public var homepage: String
        
        /// Phone numbers associated with this customer
        public var phones: [PhoneNumber_DTO.V1.Model]
        /// Email addresses associated with this customer
        public var emails: [EmailAddress_DTO.V1.Model]
        /// Street addresses associated with this customer
        public var addresses: [StreetAddress_DTO.V1.Model]
        
        /// Assignable alternative tax than the default server tax
        public var defaultTax: Tax_DTO.V1.Model?
        
        
        public init(id: Int, createdAt: Date? = nil, updatedAt: Date? = nil,
                    firstName: String, lastName: String,
                    businessCustomer: String?, homepage: String,
                    phoneNumbers: [PhoneNumber_DTO.V1.Model],
                    emailAddresses: [EmailAddress_DTO.V1.Model],
                    streetAddresses: [StreetAddress_DTO.V1.Model],
                    defaultTax: Tax_DTO.V1.Model? = nil
        ) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.firstName = firstName
            self.lastName = lastName
            self.businessCustomer = businessCustomer
            self.homepage = homepage
            self.phones = phoneNumbers
            self.emails = emailAddresses
            self.addresses = streetAddresses
            self.defaultTax = defaultTax
        }
        
        
        public static func < (lhs: Customer_DTO.V2.Model, rhs: Customer_DTO.V2.Model) -> Bool {
            return lhs.id == rhs.id
        }
        public static func == (lhs: Customer_DTO.V2.Model, rhs: Customer_DTO.V2.Model) -> Bool {
            return lhs.id == rhs.id
        }
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    /// Create a new MW Customer
    public struct CreateRequestModel: Codable {
        /// Customer first name
        public var firstName: String
        /// Customer last name
        public var lastName: String
        
        /// Customer website
        public var homepage: String
        /// Business Customer definition
        public var businessCustomer: String?
        
        /// Assign a default tax to this customer
        public var defaultTax: Tax_DTO.V1.Model?
        
        /// Phone numbers associated with this customer
        public var phoneNumbers: [PhoneNumber_DTO.V1.CreateRequest]
        /// Email addresses associated with this customer
        public var emailAddresses: [EmailAddress_DTO.V1.CreateRequest]
        /// Street addresses associated with this customer
        public var streetAddresses: [StreetAddress_DTO.V1.CreateRequest]
        
        public init (firstName: String, lastName: String, homepage: String,
                     businessCustomer: String? = nil,
                     defaultTax: Tax_DTO.V1.Model? = nil,
                     phoneNumbers: [PhoneNumber_DTO.V1.CreateRequest],
                     emailAddresses: [EmailAddress_DTO.V1.CreateRequest],
                     streetAddresses: [StreetAddress_DTO.V1.CreateRequest]
        ) {
            self.firstName = firstName
            self.lastName = lastName
            self.homepage = homepage
            self.businessCustomer = businessCustomer
            self.defaultTax = defaultTax
            self.phoneNumbers = phoneNumbers
            self.emailAddresses = emailAddresses
            self.streetAddresses = streetAddresses
        }
        
        public init (from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.firstName = try container.decode(String.self, forKey: .firstName)
            self.lastName = try container.decode(String.self, forKey: .lastName)
            self.homepage = try container.decode(String.self, forKey: .homepage)
            self.businessCustomer = try container.decodeIfPresent(String.self, forKey: .businessCustomer)
            self.defaultTax = try container.decodeIfPresent(Tax_DTO.V1.Model.self, forKey: .defaultTax)
            self.phoneNumbers = try container.decode([PhoneNumber_DTO.V1.CreateRequest].self, forKey: .phoneNumbers)
            self.emailAddresses = try container.decode([EmailAddress_DTO.V1.CreateRequest].self, forKey: .emailAddresses)
            self.streetAddresses = try container.decode([StreetAddress_DTO.V1.CreateRequest].self, forKey: .streetAddresses)
        }
    }
    
    
    /// non-nil values will be updated
    public struct UpdateRequestModel: Codable {
        /// Customer first name
        public var firstName: String?
        /// Customer last name
        public var lastName: String?
        
        /// Customer website
        public var homepage: String?
        
        /// Assign a business customer
        public var businessCustomer: String?
        /// Assign this value and it will remove the business customer
        public var removeBusinessCustomer: Bool?
        
        /// A new default tax to assign to this customer
        public var defaultTax: Tax_DTO.V1.Model?
        /// Assign this value and it will remove the default tax
        public var removeDefaultTax: Bool?
        
        /// Phone numbers associated with this customer
        public var updatedPhones: [PhoneNumber_DTO.V1.UpdateRequest]?
        /// Email addresses associated with this customer
        public var updatedEmails: [EmailAddress_DTO.V1.UpdateRequest]?
        /// Street addresses associated with this customer
        public var updatedStreets: [StreetAddress_DTO.V1.UpdateRequest]?
        
        /// New phone numbers to add
        public var newPhones: [PhoneNumber_DTO.V1.CreateRequest]?
        /// New email addresses to add
        public var newEmails: [EmailAddress_DTO.V1.CreateRequest]?
        /// New street addresses to add
        public var newStreets: [StreetAddress_DTO.V1.CreateRequest]?
        
        
        public init (
            firstName: String? = nil, lastName: String? = nil, homepage: String? = nil,
            businessCustomer: String? = nil, removeBusinessCustomer: Bool? = nil,
            defaultTax: Tax_DTO.V1.Model? = nil, removeDefaultTax: Bool? = nil,
            
            updatedPhones: [PhoneNumber_DTO.V1.UpdateRequest]? = nil,
            updatedEmails: [EmailAddress_DTO.V1.UpdateRequest]? = nil,
            updatedStreets: [StreetAddress_DTO.V1.UpdateRequest]? = nil,
            
            newPhones: [PhoneNumber_DTO.V1.CreateRequest]? = nil,
            newEmails: [EmailAddress_DTO.V1.CreateRequest]? = nil,
            newStreets: [StreetAddress_DTO.V1.CreateRequest]? = nil
        ) {
            self.firstName = firstName
            self.lastName = lastName
            self.homepage = homepage
            self.businessCustomer = businessCustomer
            self.removeBusinessCustomer = removeBusinessCustomer
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
