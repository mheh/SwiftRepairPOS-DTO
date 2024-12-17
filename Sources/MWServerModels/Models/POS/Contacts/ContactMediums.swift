import Foundation

// MARK: - Contact Medium Declarations
/// An email address from MWServer
public struct EmailAddress_DTO {
    public enum V1 {}
}

/// A street address from MWServer
public struct StreetAddress_DTO {
    public enum V1 {}
}

/// A phone number from MWServer
public struct PhoneNumber_DTO {
    public enum V1 {}
}

// MARK: - Email Address V1
private typealias EmailV1 = EmailAddress_DTO.V1

extension EmailV1 {
    /// The model returned from the server
    public struct Model: Codable, Identifiable, ContactCommunicationProtocol {
        public var id: UUID
        
        /// The email address
        public var emailAddress: String
        
        /// Whether this is the primary email address
        public var primary: Bool
        /// Whether this email address has been authenticated by the user
        public var authed: Bool
        /// Whether this email address has been approved for `non-marketing` related communication
        public var authed_communication: Bool
        /// Whether this email address has been approved for `marketing` related communication
        public var authed_marketing: Bool
        
        public init(id: UUID, primaryCommunicationMethod: Bool, emailAddress: String, authed: Bool, authComms: Bool, authMarketing: Bool) {
            self.id = id
            self.primary = primaryCommunicationMethod
            self.emailAddress = emailAddress
            self.authed = authed
            self.authed_communication = authComms
            self.authed_marketing = authMarketing
        }
    }
    
    /// Create a new email address.
    public struct CreateRequest: Codable, ContactCommunicationProtocol {
        /// The email address
        public var emailAddress: String
        
        /// Whether this is the primary email address
        public var primary: Bool
        /// Whether this email address has been authenticated by the user
        public var authed: Bool
        /// Whether this email address has been approved for `non-marketing` related communication
        public var authed_communication: Bool
        /// Whether this email address has been approved for `marketing` related communication
        public var authed_marketing: Bool
        
        public init(emailAddress: String, primaryCommunicationMethod: Bool, authed: Bool, authComms: Bool, authMarketing: Bool) {
            self.emailAddress = emailAddress
            self.primary = primaryCommunicationMethod
            self.authed = authed
            self.authed_communication = authComms
            self.authed_marketing = authMarketing
        }
    }
    
    /// Update an existing email address
    public struct UpdateRequest: Codable, Identifiable {
        public var id: UUID
        /// The email address
        public var emailAddress: String?
        
        /// Whether this is the primary email address
        public var primary: Bool?
        /// Whether this email address has been authenticated by the user
        public var authed: Bool?
        /// Whether this email address has been approved for `non-marketing` related communication
        public var authed_communication: Bool?
        /// Whether this email address has been approved for `marketing` related communication
        public var authed_marketing: Bool?
        
        public init (
            id: UUID, emailAddress: String? = nil,
            primaryCommunicationMethod: Bool? = nil, authed: Bool? = nil,
            authComms: Bool? = nil, authMarketing: Bool? = nil
        ) {
            self.id = id
            self.emailAddress = emailAddress
            self.primary = primaryCommunicationMethod
            self.authed = authed
            self.authed_communication = authComms
            self.authed_marketing = authMarketing
        }
    }
}

// MARK: - Email Address
extension EmailV1.Model: Hashable {
    public static func == (lhs: EmailAddress_DTO.V1.Model, rhs: EmailAddress_DTO.V1.Model) -> Bool {
        return lhs.id == rhs.id &&
        lhs.emailAddress == rhs.emailAddress &&
        lhs.primary == rhs.primary &&
        lhs.authed == rhs.authed &&
        lhs.authed_communication == rhs.authed_communication &&
        lhs.authed_marketing == rhs.authed_marketing
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(emailAddress)
        hasher.combine(primary)
        hasher.combine(authed)
        hasher.combine(authed_communication)
        hasher.combine(authed_marketing)
    }
}
extension EmailV1.CreateRequest: Hashable {
    public static func == (lhs: EmailAddress_DTO.V1.CreateRequest, rhs: EmailAddress_DTO.V1.CreateRequest) -> Bool {
        return lhs.emailAddress == rhs.emailAddress &&
        lhs.primary == rhs.primary &&
        lhs.authed == rhs.authed &&
        lhs.authed_communication == rhs.authed_communication &&
        lhs.authed_marketing == rhs.authed_marketing
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(emailAddress)
        hasher.combine(primary)
        hasher.combine(authed)
        hasher.combine(authed_communication)
        hasher.combine(authed_marketing)
    }
}


// MARK: - Street Address V1
private typealias StreetAddressV1 = StreetAddress_DTO.V1

/// `PhoneNumber` models should have these fields
fileprivate protocol StreetAddressProtocol: Codable, Hashable, ContactCommunicationProtocol {
    /// What type of address this is
    var addressType: StreetAddressV1.StreetAddressType { get set }
    
    /// The street address
    var address1: String { get set }
    /// The suite or apartment number
    var address2: String { get set }
    /// The city    
    var city: String { get set }
    /// The state
    var state: String { get set }
    /// The zip code
    var zip: String { get set }
    /// The country (two-letter code)
    var country: StreetAddressV1.CountryCodes_Alpha2 { get set }
}


extension StreetAddressV1 {
  
    
    /// The model returned from the server
    public struct Model: StreetAddressProtocol, Identifiable {
        
        public var id: UUID

        /// What type of address is this?
        public var addressType: StreetAddressType
        
        /// `123 West Cove Street`
        public var address1: String
        /// `Suite 200`
        public var address2: String
        /// `New York`
        public var city: String
        /// `NY`
        public var state: String
        /// `00001`
        public var zip: String
        /// `USA`
        public var country: CountryCodes_Alpha2
        
        /// Whether this is the street address
        public var primary: Bool
        /// Whether this address has been authenticated by the user
        public var authed: Bool
        /// Whether this address has been approved for `non-marketing` related communication
        public var authed_communication: Bool
        /// Whether this address has been approved for `marketing` related communication
        public var authed_marketing: Bool
        
        public init(id: UUID, addressType: StreetAddressType, address1: String, address2: String, city: String, state: String, zip: String, country: CountryCodes_Alpha2, primary: Bool, authed: Bool, authed_communication: Bool, authed_marketing: Bool) {
            self.id = id
            self.addressType = addressType
            self.address1 = address1
            self.address2 = address2
            self.city = city
            self.state = state
            self.zip = zip
            self.country = country
            self.primary = primary
            self.authed = authed
            self.authed_communication = authed_communication
            self.authed_marketing = authed_marketing
        }
    }
    
    /// Create a new address
    public struct CreateRequest: Codable, ContactCommunicationProtocol {
        /// Billing or Shipping
        public var addressType: StreetAddressType
        
        /// `123 West Cove Street`
        public var address1: String
        /// `Suite 200`
        public var address2: String
        /// `New York`
        public var city: String
        /// `NY`
        public var state: String
        /// `00001`
        public var zip: String
        /// `USA`
        public var country: CountryCodes_Alpha2
        
        /// Whether this is the street address
        public var primary: Bool
        /// Whether this address has been authenticated by the user
        public var authed: Bool
        /// Whether this address has been approved for `non-marketing` related communication
        public var authed_communication: Bool
        /// Whether this address has been approved for `marketing` related communication
        public var authed_marketing: Bool
        
        public init(
            addressType: StreetAddressType,
            address1: String, address2: String,
            city: String, state: String, zip: String, country: CountryCodes_Alpha2,
            primaryCommunicationMethod: Bool, authed: Bool,
            authComms: Bool, authMarketing: Bool
        ) {
            self.addressType = addressType
            self.address1 = address1
            self.address2 = address2
            self.city = city
            self.state = state
            self.zip = zip
            self.country = country
            self.primary = primaryCommunicationMethod
            self.authed = authed
            self.authed_communication = authComms
            self.authed_marketing = authMarketing
        }
    }
    
    /// Update an existing address
    public struct UpdateRequest: Codable, Identifiable {
        public var id: UUID
        
        /// Billing or Shipping
        public var addressType: StreetAddressType?
        
        /// `123 West Cove Street`
        public var address1: String?
        /// `Suite 200`
        public var address2: String?
        /// `New York`
        public var city: String?
        /// `NY`
        public var state: String?
        /// `00001`
        public var zip: String?
        /// `USA`
        public var country: CountryCodes_Alpha2?
        
        /// Whether this is the street address
        public var primary: Bool?
        /// Whether this address has been authenticated by the user
        public var authed: Bool?
        /// Whether this address has been approved for `non-marketing` related communication
        public var authed_communication: Bool?
        /// Whether this address has been approved for `marketing` related communication
        public var authed_marketing: Bool?
        
        public init(
            id: UUID, 
            
            addressType: StreetAddressType?,
            
            address1: String? = nil, address2: String? = nil,
            city: String? = nil, 
            state: String? = nil,
            zip: String? = nil,
            country: CountryCodes_Alpha2? = nil,
            
            primaryCommunicationMethod: Bool? = nil, 
            authed: Bool? = nil,
            authComms: Bool? = nil, 
            authMarketing: Bool? = nil
        ) {
            self.id = id
            self.addressType = addressType
            self.address1 = address1
            self.address2 = address2
            self.city = city
            self.state = state
            self.zip = zip
            self.country = country
            self.primary = primaryCommunicationMethod
            self.authed = authed
            self.authed_communication = authComms
            self.authed_marketing = authMarketing
        }
    }
}

// MARK: Hashable
extension StreetAddressV1.Model: Hashable {
    public static func == (lhs: StreetAddress_DTO.V1.Model, rhs: StreetAddress_DTO.V1.Model) -> Bool {
        return lhs.id == rhs.id &&
        lhs.addressType == rhs.addressType &&
        lhs.address1 == rhs.address1 &&
        lhs.address2 == rhs.address2 &&
        lhs.city == rhs.city &&
        lhs.state == rhs.state &&
        lhs.zip == rhs.zip &&
        lhs.country == rhs.country &&
        lhs.primary == rhs.primary &&
        lhs.authed == rhs.authed &&
        lhs.authed_communication == rhs.authed_communication &&
        lhs.authed_marketing == rhs.authed_marketing
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(addressType)
        hasher.combine(address1)
        hasher.combine(address2)
        hasher.combine(city)
        hasher.combine(state)
        hasher.combine(zip)
        hasher.combine(country)
        hasher.combine(primary)
        hasher.combine(authed)
        hasher.combine(authed_communication)
        hasher.combine(authed_marketing)
    }
}
extension StreetAddressV1.CreateRequest: Hashable {
    public static func == (lhs: StreetAddress_DTO.V1.CreateRequest, rhs: StreetAddress_DTO.V1.CreateRequest) -> Bool {
        return lhs.addressType == rhs.addressType &&
        lhs.address1 == rhs.address1 &&
        lhs.address2 == rhs.address2 &&
        lhs.city == rhs.city &&
        lhs.state == rhs.state &&
        lhs.zip == rhs.zip &&
        lhs.country == rhs.country &&
        
        lhs.primary == rhs.primary &&
        lhs.authed == rhs.authed &&
        lhs.authed_communication == rhs.authed_communication &&
        lhs.authed_marketing == rhs.authed_marketing
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(addressType)
        hasher.combine(address1)
        hasher.combine(address2)
        hasher.combine(city)
        hasher.combine(state)
        hasher.combine(zip)
        hasher.combine(country)
        hasher.combine(primary)
        hasher.combine(authed)
        hasher.combine(authed_communication)
        hasher.combine(authed_marketing)
    }
}



// MARK: - Phone Number V1
private typealias PhoneV1 = PhoneNumber_DTO.V1

/// `PhoneNumber` models should have these fields
fileprivate protocol PhoneProtocol: Codable, Hashable, ContactCommunicationProtocol {
    var phoneType: PhoneV1.PhoneType { get set }
    var number: String { get set }
}

extension PhoneProtocol {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.number == rhs.number &&
        lhs.phoneType == rhs.phoneType &&
        lhs.primary == rhs.primary &&
        lhs.authed == rhs.authed &&
        lhs.authed_communication == rhs.authed_communication &&
        lhs.authed_marketing == rhs.authed_marketing
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(number)
        hasher.combine(phoneType)
        hasher.combine(primary)
        hasher.combine(authed)
        hasher.combine(authed_communication)
        hasher.combine(authed_marketing)
    }
}

extension PhoneV1 {
    /// The model returned from the server
    public struct Model: PhoneProtocol, Identifiable {
        public var id: UUID
        
        /// The type of phone number
        public var phoneType: PhoneType
        /// The actual number without formatting
        public var number: String
        
        /// Whether this is the primary phone number
        public var primary: Bool
        /// Whether this phone number has been authenticated by the user
        public var authed: Bool
        /// Whether this phone number has been approved for `non-marketing` related communication
        public var authed_communication: Bool
        /// Whether this phone number has been approved for `marketing` related communication
        public var authed_marketing: Bool
        
        public init(id: UUID, phoneType: PhoneType, number: String, primaryCommunicationMethod: Bool, authed: Bool, authComms: Bool, authMarketing: Bool) {
            self.id = id
            self.primary = primaryCommunicationMethod
            self.phoneType = phoneType
            self.number = number
            self.authed = authed
            self.authed_communication = authComms
            self.authed_marketing = authMarketing
        }
    }
    
    /// Create a new phone number
    public struct CreateRequest: PhoneProtocol {
        /// The type of phone number
        public var phoneType: PhoneType
        /// The actual number without formatting
        public var number: String
        
        /// Whether this is the primary phone number
        public var primary: Bool
        /// Whether this phone number has been authenticated by the user
        public var authed: Bool
        /// Whether this phone number has been approved for `non-marketing` related communication
        public var authed_communication: Bool
        /// Whether this phone number has been approved for `marketing` related communication
        public var authed_marketing: Bool
        
        public init(
            phoneType: PhoneType, number: String,
            primaryCommunicationMethod: Bool, authed: Bool,
            authComms: Bool, authMarketing: Bool
        ) {
            self.phoneType = phoneType
            self.number = number
            self.primary = primaryCommunicationMethod
            self.authed = authed
            self.authed_communication = authComms
            self.authed_marketing = authMarketing
        }
    }
    
    /// Update an existing phone number
    public struct UpdateRequest: Codable, Identifiable {
        /// The ID of the phone number to update
        public var id: UUID
        
        /// The type of phone number
        public var phoneType: PhoneType?
        /// The actual number without formatting
        public var number: String?
        
        /// Whether this is the primary phone number
        public var primaryCommunicationMethod: Bool?
        /// Whether this phone number has been authenticated by the user
        public var authed: Bool?
        /// Whether this phone number has been approved for `non-marketing` related communication
        public var authComms: Bool?
        /// Whether this phone number has been approved for `marketing` related communication
        public var authMarketing: Bool?
        
        public init(
            id: UUID, phoneType: PhoneType? = nil, number: String? = nil,
            primaryCommunicationMethod: Bool? = nil, authed: Bool? = nil,
            authComms: Bool? = nil, authMarketing: Bool? = nil
        ) {
            self.id = id
            self.phoneType = phoneType
            self.number = number
            self.primaryCommunicationMethod = primaryCommunicationMethod
            self.authed = authed
            self.authComms = authComms
            self.authMarketing = authMarketing
        }
    }
}

// MARK: Hashable
extension PhoneV1.Model: Hashable {
    public static func == (lhs: PhoneNumber_DTO.V1.Model, rhs: PhoneNumber_DTO.V1.Model) -> Bool {
        return lhs.id == rhs.id &&
        lhs.number == rhs.number &&
        lhs.phoneType == rhs.phoneType &&
        lhs.primary == rhs.primary &&
        lhs.authed == rhs.authed &&
        lhs.authed_communication == rhs.authed_communication &&
        lhs.authed_marketing == rhs.authed_marketing
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(number)
        hasher.combine(phoneType)
        hasher.combine(primary)
        hasher.combine(authed)
        hasher.combine(authed_communication)
        hasher.combine(authed_marketing)
    }
}


// MARK: PhoneType Enum
extension PhoneV1 {
    /// The type of phone number for the customer
    public enum PhoneType: String, Codable {
        /// A mobile phone
        case mobile = "mobile"
        /// A home phone
        case home = "home"
        /// A work phone
        case work = "work"
        /// A miscellaneous phone
        case misc = "misc"
    }
}
extension PhoneV1.PhoneType: CaseIterable {}
extension PhoneV1.PhoneType: Identifiable {
    public var id: String { rawValue }
}


extension StreetAddress_DTO.V1 {
    
    /// The type of StreetAddress
    public enum StreetAddressType: String, Codable {
        case billing
        case shipping
    }
    
    /// two letter country codes
    public enum CountryCodes_Alpha2: String, Codable, CaseIterable {
        case AF,
             AL,
             DZ,
             AS,
             AD,
             AO,
             AI,
             AQ,
             AG,
             AR,
             AM,
             AW,
             AU,
             AT,
             AZ,
             BS,
             BH,
             BD,
             BB,
             BY,
             BE,
             BZ,
             BJ,
             BM,
             BT,
             BO,
             BQ,
             BA,
             BW,
             BV,
             BR,
             IO,
             BN,
             BG,
             BF,
             BI,
             KH,
             CM,
             CA,
             CV,
             KY,
             CF,
             TD,
             CL,
             CN,
             CX,
             CC,
             CO,
             KM,
             CG,
             CD,
             CK,
             CR,
             HR,
             CU,
             CW,
             CY,
             CZ,
             CI,
             DK,
             DJ,
             DM,
             DO,
             EC,
             EG,
             SV,
             GQ,
             ER,
             EE,
             ET,
             FK,
             FO,
             FJ,
             FI,
             FR,
             GF,
             PF,
             TF,
             GA,
             GM,
             GE,
             DE,
             GH,
             GI,
             GR,
             GL,
             GD,
             GP,
             GU,
             GT,
             GG,
             GN,
             GW,
             GY,
             HT,
             HM,
             VA,
             HN,
             HK,
             HU,
             IS,
             IN,
             ID,
             IR,
             IQ,
             IE,
             IM,
             IL,
             IT,
             JM,
             JP,
             JE,
             JO,
             KZ,
             KE,
             KI,
             KP,
             KR,
             KW,
             KG,
             LA,
             LV,
             LB,
             LS,
             LR,
             LY,
             LI,
             LT,
             LU,
             MO,
             MK,
             MG,
             MW,
             MY,
             MV,
             ML,
             MT,
             MH,
             MQ,
             MR,
             MU,
             YT,
             MX,
             FM,
             MD,
             MC,
             MN,
             ME,
             MS,
             MA,
             MZ,
             MM,
             NA,
             NR,
             NP,
             NL,
             NC,
             NZ,
             NI,
             NE,
             NG,
             NU,
             NF,
             MP,
             NO,
             OM,
             PK,
             PW,
             PS,
             PA,
             PG,
             PY,
             PE,
             PH,
             PN,
             PL,
             PT,
             PR,
             QA,
             RO,
             RU,
             RW,
             RE,
             BL,
             SH,
             KN,
             LC,
             MF,
             PM,
             VC,
             WS,
             SM,
             ST,
             SA,
             SN,
             RS,
             SC,
             SL,
             SG,
             SX,
             SK,
             SI,
             SB,
             SO,
             ZA,
             GS,
             SS,
             ES,
             LK,
             SD,
             SR,
             SJ,
             SZ,
             SE,
             CH,
             SY,
             TW,
             TJ,
             TZ,
             TH,
             TL,
             TG,
             TK,
             TO,
             TT,
             TN,
             TR,
             TM,
             TC,
             TV,
             UG,
             UA,
             AE,
             GB,
             US,
             UM,
             UY,
             UZ,
             VU,
             VE,
             VN,
             VG,
             VI,
             WF,
             EH,
             YE,
             ZM,
             ZW,
             AX
    }
    
}
