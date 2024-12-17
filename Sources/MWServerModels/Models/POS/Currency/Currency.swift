import Foundation


// MARK: - Currencies
/// Currency settings: taxes and available currencies.
public struct Currency_DTO {
    public enum V1 {}
}


// MARK: - V3
fileprivate typealias V1 = Currency_DTO.V1

extension V1: MWDTO_CRUDModel {
    static public var path: String = "server_settings/currencies"
    
    public struct Model: Codable, Identifiable, Hashable {
        // MARK: Identification
        /// The server's unique identifier for this currency
        public var id: UUID
        /// User define name for this currency
        public var name: String
        
        // MARK: Date Tracking
        public var createdAt: Date
        public var updatedAt: Date
        public var deletedAt: Date?
        
        // MARK: Currency Information
        /// The default exchange rate should be `1.0`
        public var exchangeRate: Decimal
        /// The ISO4217 currency code used by `NumberFormatter`
        public var code: CurrencyCodes
        
        
        // MARK: Bools
        /// Whether this is the default currency
        public var isDefault: Bool
        
        // MARK: Computed Values
        /// The decimal places for this currency
        public var decimalPlaces: Int {
            switch self.code {
            case .USD, .CAD, .AUD, .MXN:
                return 2
            case .EUR:
                return 2
            case .GBP:
                return 2
            case .JPY:
                return 0
            }
        }
        
        /// `NumberFormatter` for this currency type.
        public var formatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = self.code.rawValue
            formatter.maximumFractionDigits = self.decimalPlaces
            return formatter
        }
        
        /// Initializer for response from the server
        public init(id: UUID, name: String, createdAt: Date, updatedAt: Date, deletedAt: Date?, exchangeRate: Decimal, code: CurrencyCodes, isDefault: Bool) {
            self.id = id
            self.name = name
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.deletedAt = deletedAt
            self.exchangeRate = exchangeRate
            self.code = code
            self.isDefault = isDefault
        }
        
        public init(testing: Bool, code: CurrencyCodes, exchangeRate: Decimal = 1.00) {
            self.init(id: UUID(), name: "\(code)", createdAt: Date(), updatedAt: Date(), deletedAt: nil, exchangeRate: exchangeRate, code: code, isDefault: true)
        }
    }
    
    /// Create a new currency at the server
    public struct CreateRequestModel: Codable {
        /// User defined name for the currency
        public var name: String
        /// The code for the currency
        public var code: CurrencyCodes
        /// Make this currency the default
        public var isDefault: Bool
        /// The exchange rate for this currency
        public var exchangeRate: Decimal
        
        public init(name: String, code: CurrencyCodes, isDefault: Bool, exchangeRate: Decimal) {
            self.name = name
            self.code = code
            self.isDefault = isDefault
            self.exchangeRate = exchangeRate
        }
    }
    

    /// Update an existing currency at the server
    /// Useful for manually updating the exchange rate
    public struct UpdateRequestModel: Codable {
        public var name: String?
        public var code: CurrencyCodes?
        public var isDefault: Bool?
        public var exchangeRate: Decimal?
        
        public init(name: String?, code: CurrencyCodes?, isDefault: Bool?, exchangeRate: Decimal?) {
            self.name = name
            self.code = code
            self.isDefault = isDefault
            self.exchangeRate = exchangeRate
        }
    }
    
    
    /// The decimal places for this currency
    public static func decimalPlaces(_ code: CurrencyCodes) -> Int {
        switch code {
        case .USD, .CAD, .AUD, .MXN:
            return 2
        case .EUR:
            return 2
        case .GBP:
            return 2
        case .JPY:
            return 0
        }
    }
    
    /// Currency code `type`s used in Swift's `NumberFormatter`
    public enum CurrencyCodes: String, Codable, CaseIterable {
        /// US Dollar
        case USD
        /// Euro
        case EUR
        /// Pound Sterling
        case GBP
        /// Japanese Yen
        case JPY
        /// Australian Dollar
        case AUD
        /// Canadian Dollar
        case CAD
        /// Mexican Peso
        case MXN
    }
}

extension V1 {
    /// Get all currencies available at the server
    public struct GetAllRequest: MWRequestProtocol {
        public var path: String = "server_settings/currencies"
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .GET
        public var response: Decodable.Type? = nil
        public var body: Encodable? = nil
        
        public init() {}
    }
}
