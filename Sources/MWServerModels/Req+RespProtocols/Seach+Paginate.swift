import Foundation

/// For `ReadAll` request models we need to pass query information
/// This protocol should allow advanced searching and filtering done at the server
public protocol MWSearchURLQueryTermsProtocol: Codable {
    // MARK: Global Search
    /// The `ID` string to search for, if NO fields are included.
    /// If fields are included, this is ignored
    var idText: String { get set }
    /// Global search start date
    var createdStartDate: Date? { get set }
    /// Global search end date
    var createdEndDate: Date? { get set }
    
    // MARK: Ordering
    /// Whether the results are ascending or descending
    var ascending: Bool { get set }
    /// The field we want to sort by.
    /// Default is the `createdAt` date field
    var ascendingField: String? { get set }
    
    // MARK: Advanced Searching
    /// Dictionary containing
    /// key: `Target Field` to search on a model
    /// value: `AdvancedFieldSearchTerm` information to process on that field
    var fields: [String: String] { get set }
}

/// For paginated responses, this is used to query the server
public struct MWSearchURLQueryTerms: MWSearchURLQueryTermsProtocol {
    public var idText: String
    public var ascending: Bool
    public var ascendingField: String?
    public var createdStartDate: Date?
    public var createdEndDate: Date?
    public var fields: [String: String]
    
    public init(
        searchText: String = "",
        startDate: Date? = nil,
        endDate: Date? = nil,
        ascending: Bool = true,
        sortByField: String? = nil,
        fields: [String: String] = [:]
    ) {
        self.idText = searchText
        self.createdStartDate = startDate
        self.createdEndDate = endDate
        self.ascending = ascending
        self.ascendingField = sortByField
        self.fields = fields
    }
    
    public init(testing: Bool) throws {
        guard testing else {
            throw MWSearchURLQueryTermsError.init(message: "This initializer is for testing only.")
        }
        self.init(
            searchText: "",
            startDate: nil,
            endDate: nil,
            ascending: true,
            sortByField: nil,
            fields: [:]
        )
    }
    
    /// The error type for the `MWSearchURLQueryTerms` struct
    public struct MWSearchURLQueryTermsError: Error {
        /// The error message
        var message: String
        public init(message: String) {
            self.message = message
        }
    }
}

// MARK: - Pagination and Metadata
/// Lifted from `fluent-kit` in order to not include the whole of fluent-kit
public struct PageMetadata: Codable {
    /// Current page number. Starts at `1`.
    public var page: Int
    
    /// Max items per page.
    public var per: Int
    
    /// Total number of items available.
    public var total: Int
    
    /// Computed total number of pages with `1` being the minimum.
    public var pageCount: Int {
        let count = Int((Double(self.total)/Double(self.per)).rounded(.up))
        return count < 1 ? 1 : count
    }
    
    /// Creates a new `PageMetadata` instance.
    ///
    /// - Parameters:
    ///.  - page: Current page number.
    ///.  - per: Max items per page.
    ///.  - total: Total number of items available.
    public init(page: Int = 0, per: Int = 0, total: Int = 0) {
        self.page = page
        self.per = per
        self.total = total
    }
}

extension PageMetadata {
    /// Generates a string dictionary for URL queries
    /// Returns a partial of this struct:
    ///     `page`
    ///     `per`
    public func generateStringDictionary() -> [String: String] {
        var dictionary: [String: String] = [:]
        dictionary["page"] = String(self.page)
        dictionary["per"] = String(self.per)
        return dictionary
    }
}
