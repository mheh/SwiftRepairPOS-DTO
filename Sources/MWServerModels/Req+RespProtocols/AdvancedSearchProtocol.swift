import Foundation


/// Make a `MWServerModels` model advanced searchable at the server
public protocol AdvancedSearchableProtocol: MWDTO_CRUDModel {
    
    /// All the fields available to search through at the server
    associatedtype AllFields: Codable, CaseIterable, Identifiable
    
    
}


public struct DTOSearchRequest<DTO: AdvancedSearchableProtocol>: MWRequestProtocol {
    public var path: String
    public var urlQueryParams: [String : String] = [:]
    public var requestType: MWRequest_HTTPType = .POST
    public var response: Decodable.Type? = nil
    public var body: Encodable?
    
    public init(search: DTOSearchRequestModel<DTO>) {
        self.path = "\(DTO.path)/search"
        self.body = search
    }
}

/// The request model for performing advanced searches at the server
public struct DTOSearchRequestModel<DTOType: AdvancedSearchableProtocol>: Codable {
    
    /// The fields to search through at the server
    public var filterFields: [DTOSearch_Field<DTOType>]
    
    /// The field to sort by
    public var sortField: DTOSearch_SortDefinition
}



/// A single instance of a field to search through.
public struct DTOSearch_Field<DTOType: AdvancedSearchableProtocol>: Codable, Identifiable {
    /// We can only ever search through a field once, so the ID is always the `columnName`
    public var id: String { self.key.id }
    
    /// The field and how to filter it
    public var key: DTOSearch_ColumnDefinition
    
    /// The value to filter the field by
    public var value: String
}


/// Define a field for sorting.
///
/// - Parameters:
///     - sortField: The field to sort by at the server
///     - sortType: The way to sort by
public struct DTOSearch_SortDefinition: Codable, Identifiable {
    public var id: String { self.sortField.id }
    
    /// The field to sort by at the server
    public var sortField: DTOSearch_ColumnDefinition
    
    /// The way to sort by
    public var sortType: SortType
    
    /// The different sorting types available
    public enum SortType: String, Codable, Identifiable, CaseIterable, Hashable {
        public var id: String { self.rawValue }
        
        case ascending = "ascending"
        case descending = "descending"
    }
}

/// Definition of a column at the server.
///
/// - Parameters:
///     - columnName: The `column` name in a frontend presentable form.
///     - filterType: How to filter the rows
public struct DTOSearch_ColumnDefinition: Codable, Identifiable {
    /// The `columnName` should only appear once when presenting an array at the frontend
    public var id: String { self.columnName }
    
    
    /// The `column` name in a frontend presentable form.
    /// This variable is used in the switch statement at the server to choose which field to filter.
    /// Ex: The field at the server is `id` but this value stores `Customer ID`
    public var columnName: String
    
    /// The way to perform the search through this field
    public var filterType: FilterTypes
    
    
    /// The different ways to filter a field at the server
    public enum FilterTypes: String, Codable, Identifiable, CaseIterable, Hashable {
        public var id: String { self.rawValue }
        
        case equals = "equals"
        case contains = "contains"
        case startsWith = "startsWith"
        case endsWith = "endsWith"
    }
}
