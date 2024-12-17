import Foundation

/// Documents like a `ServiceOrder` or `Invoice` will use this object to contain contact information
public protocol DocumentContactFieldsProtocol {
    var contact: DocumentContactInformation { get set }
}


/// The model to contain contact information for documents
public struct DocumentContactInformation: Codable, Hashable {
    
    /// When returning contact information for a document from the server, this is the model used
    public struct Model: Codable, Hashable {
        
        // MARK: Naming
        
        /// If this customer exists at the server, the ID will be populated
        public var customerID: Int?
        
        public var firstName: String
        
        public var lasttName: String
        
        public var fullName: String { return "\(firstName) \(lasttName)" }
        
        public var businessName: String?
        
        
        
        // MARK: Contact Information
        
        public var emails: [EmailAddress_DTO.V1.Model]
        
        public var phones: [PhoneNumber_DTO.V1.Model]
        
        public var addresses: [StreetAddress_DTO.V1.Model]
        
        public init(
            customerID: Int? = nil,
            firstName: String,
            lasttName: String,
            businessName: String? = nil,
            emails: [EmailAddress_DTO.V1.Model],
            phones: [PhoneNumber_DTO.V1.Model],
            addresses: [StreetAddress_DTO.V1.Model]
        ) {
            self.customerID = customerID
            self.firstName = firstName
            self.lasttName = lasttName
            self.businessName = businessName
            self.emails = emails
            self.phones = phones
            self.addresses = addresses
        }
    }
    
    /// When creating a new document, this model is used to create the contact information
    public struct CreateRequestModel: Codable {
        /// Assign an existing `CustomerID` to this document
        public var customerID: Int?
        
        /// The first name of the customer
        public var firstName: String
        
        /// The last name of the customer
        public var lasttName: String
        
        /// The business name, if any
        public var businessName: String?
        
        
        // MARK: Contact Information
        
        public var emails: [EmailAddress_DTO.V1.CreateRequest]
        
        public var phones: [PhoneNumber_DTO.V1.CreateRequest]
        
        public var addresses: [StreetAddress_DTO.V1.CreateRequest]
        
        public init(
            customerID: Int? = nil, 
            firstName: String, 
            lasttName: String,
            businessName: String? = nil,
            emails: [EmailAddress_DTO.V1.CreateRequest],
            phones: [PhoneNumber_DTO.V1.CreateRequest],
            addresses: [StreetAddress_DTO.V1.CreateRequest]
        ) {
            self.customerID = customerID
            self.firstName = firstName
            self.lasttName = lasttName
            self.businessName = businessName
            self.emails = emails
            self.phones = phones
            self.addresses = addresses
        }
    }
}

