import Foundation

/// MWServer Web Request conformance
public protocol MWRequestProtocol {
    /// The path of the request
    var path: String { get }
    /// The query parameters for the request
    /// Defaults to `[:]`
    var urlQueryParams: [String: String] { get set }
    /// The HTTP Method for the request
    /// Example: .GET, .POST, .PUT, .DELETE
    var requestType: MWRequest_HTTPType { get }
    /// The headers for the request
    /// Defaults to `[]`
    var headers: [MWRequest_HeadersKey] { get }
    /// Whether to add the authorization header key
    /// Defaults to `true`
    var addAuthorizationToken: Bool { get }
    /// The body of the request
    /// Defaults to `nil`
    var body: Encodable? { get set }
    
    /// Valid responses for a request
    var response: Decodable.Type? { get }
}

// MARK: MWRequestProtocol Default Implementation
extension MWRequestProtocol {
    public var urlQueryParams: [String: String]    { [:] }
    public var headers: [MWRequest_HeadersKey]     { [.contentType(.json) ] }
    public var addAuthorizationToken: Bool         { true }
    public var body: Encodable?                    { nil }
}

/// MWServer accepted types of HTTP requests
public enum MWRequest_HTTPType: String {
    case GET, POST, PUT, DELETE
}

/// MWServer Request Headers
public enum MWRequest_HeadersKey {
    /// Content type of request
    case contentType(MWRequest_ContentType)
}

/// Valid Content Types for MW Server Interaction
public enum MWRequest_ContentType: String {
    case json = "application/json"
    case text = "text/plain"
}


// MARK: - CRUD requirements for models in this package

/// This requires any DTO in this package to have consistent models for CRUD operations
public protocol MWDTO_CRUDModel {
    
    /// The path relative to `https://serveraddress:port/api/`
    /// Example: `static var path: String = "customers"` which will be referred to in the associated `MWRequest` objects on a `MWDTO_CRUDModel` conforming struct
    static var path: String { get }
    
    // MARK: DTO Models
    
    /// A full implementation of the model when everything is returned by the server
    associatedtype Model: Codable, Identifiable, Hashable
    /// An array of either `Model` or `MinimumModel` with metadata
    associatedtype GetAllModel: MWDTO_CRUDModel_GetAllModelProtocol
    /// The model used for a CreateRequest
    associatedtype CreateRequestModel: Codable
    /// The model for updating information at the server
    associatedtype UpdateRequestModel: Codable
    
    
    // MARK: AdvancedFieldSearchKeys
    /// The field keys available to search through at the server
    associatedtype ModelFields: Codable, CaseIterable


    // MARK: Request Models
    
    /// The request for creating a new model at the server
    associatedtype CreateRequest: MWRequest_CreateRequestProtocol
    /// The request for reading a single model from the server
    associatedtype ReadRequest: MWRequest_ReadRequestProtocol
    /// The request for searching all models from the server
    associatedtype SearchAllRequest: MWRequest_SearchAllRequestProtocol
    /// The request for updating a single model at the server
    associatedtype UpdateRequest: MWRequest_UpdateRequestProtocol
    /// The request for deleting amodel at the server
    associatedtype DeleteRequest: MWRequest_DeleteRequestProtocol
}

// MARK: AdvancedFieldSearchKeyProtocol
/// Default searchable model fields provided to `MWDTO_CRUDModel` structs that don't have their own implementation
public enum MWDTO_CRUDModel_ModelFields<DTO: MWDTO_CRUDModel>: String, Codable, CaseIterable {
    case id = "id"
    case createdAt = "createdAt"
    case updatedAt = "updatedAt"
}


extension MWDTO_CRUDModel {
    // MARK: Models
    public typealias GetAllModel = MWDTO_CRUDModel_GetAllModel<Self>
    
    // MARK: AdvancedFieldSearchKeyProtocol
    public typealias ModelFields = MWDTO_CRUDModel_ModelFields<Self>
    
    /// HOW DOES THIS WORK? DOES THIS WORK? IS THIS NECESSARY?
    public var defaultModelFieldKeys: [MWDTO_CRUDModel_ModelFields<Self>] {
        [.id, .createdAt, .updatedAt]
    }
    
    
    // MARK: Requests
    public typealias CreateRequest = MWRequest_CreateRequest<Self>
    public typealias ReadRequest = MWRequest_ReadRequest<Self>
    public typealias SearchAllRequest = MWRequest_SearchAllRequest<Self>
    public typealias UpdateRequest = MWRequest_UpdateRequest<Self>
    public typealias DeleteRequest = MWRequest_DeleteRequest<Self>
}

// MARK: GetAllModel definition

/// Requirements for the `GetAllModel` associated with `MWDTO_CRUDModel`
public protocol MWDTO_CRUDModel_GetAllModelProtocol<DTO>: Codable {
    associatedtype DTO: MWDTO_CRUDModel
    /// The paginated items returned from the server
    var items: [DTO.Model] { get set }
    /// Pagination information from the server
    var metaData: PageMetadata { get set }
}

/// Requirements for a `GetAllModel` from the server.
public struct MWDTO_CRUDModel_GetAllModel<DTO: MWDTO_CRUDModel>: MWDTO_CRUDModel_GetAllModelProtocol {
    /// Paginated items returned from the server
    public var items: [DTO.Model]
    /// Pagination data from the server
    public var metaData: PageMetadata
    
    public init(items: [DTO.Model], metaData: PageMetadata) {
        self.items = items
        self.metaData = metaData
    }
}


// MARK: - Request Implementations

/// Required initializer for a `CreateRequest`
public protocol MWRequest_CreateRequestProtocol<DTO>: MWRequestProtocol {
    associatedtype DTO: MWDTO_CRUDModel
    init(model: DTO.CreateRequestModel)
}
public struct MWRequest_CreateRequest<DTO: MWDTO_CRUDModel>: MWRequest_CreateRequestProtocol {
    public var path: String
    public var urlQueryParams: [String : String] = [:]
    public var requestType: MWRequest_HTTPType = .POST
    public var response: Decodable.Type? = nil
    public var body: Encodable?
    
    public init(model: DTO.CreateRequestModel) {
        self.path = DTO.path
        self.body = model
    }
}


/// Required initializer for a `ReadRequest`
public protocol MWRequest_ReadRequestProtocol<DTO>: MWRequestProtocol {
    associatedtype DTO: MWDTO_CRUDModel
    init(id: DTO.Model.ID)
}
public struct MWRequest_ReadRequest<DTO: MWDTO_CRUDModel>: MWRequest_ReadRequestProtocol {
    public var path: String
    public var urlQueryParams: [String : String] = [:]
    public var requestType: MWRequest_HTTPType = .GET
    public var response: Decodable.Type? = nil
    public var body: Encodable? = nil
    
    public init(id: DTO.Model.ID) {
        self.path = "\(DTO.path)/\(id)"
    }
}


/// Required initiailizer for a `ReadAllRequest`
/// Also contains `modelFields` which is an array of model fields we allow to search through at the server.
public protocol MWRequest_SearchAllRequestProtocol<DTO>: MWRequestProtocol {
    associatedtype DTO: MWDTO_CRUDModel
    init(searchQuery: MWSearchURLQueryTerms, metaData: PageMetadata) throws
}


public struct MWRequest_SearchAllRequest<DTO: MWDTO_CRUDModel>: MWRequest_SearchAllRequestProtocol {
    public var path: String
    public var urlQueryParams: [String : String] = [:]
    public var requestType: MWRequest_HTTPType = .POST
    public var response: Decodable.Type? = nil
    public var body: Encodable?
    
    public init(searchQuery: MWSearchURLQueryTerms, metaData: PageMetadata) throws {
        self.path = "\(DTO.path)/search"
        self.body = searchQuery
        
        let metaDataQueries = metaData.generateStringDictionary()
        for query in metaDataQueries {
            self.urlQueryParams[query.key] = query.value
        }
    }
}


/// Required initializer for a `UpdateRequest`
public protocol MWRequest_UpdateRequestProtocol<DTO>: MWRequestProtocol {
    associatedtype DTO: MWDTO_CRUDModel
    init(id: DTO.Model.ID, body: DTO.UpdateRequestModel)
}
public struct MWRequest_UpdateRequest<DTO: MWDTO_CRUDModel>: MWRequest_UpdateRequestProtocol {
    public var path: String
    public var urlQueryParams: [String : String] = [:]
    public var requestType: MWRequest_HTTPType = .PUT
    public var response: Decodable.Type? = nil
    public var body: Encodable?
    
    public init(id: DTO.Model.ID, body: DTO.UpdateRequestModel) {
        self.path = "\(DTO.path)/\(id)"
        self.body = body
    }
}


/// Required intializer for a `DeleteRequest`
public protocol MWRequest_DeleteRequestProtocol<DTO>: MWRequestProtocol {
    associatedtype DTO: MWDTO_CRUDModel
    init(id: DTO.Model.ID)
}
public struct MWRequest_DeleteRequest<DTO: MWDTO_CRUDModel>: MWRequest_DeleteRequestProtocol {
    public var path: String
    public var urlQueryParams: [String : String] = [:]
    public var requestType: MWRequest_HTTPType = .DELETE
    public var response: Decodable.Type? = nil
    public var body: Encodable? = nil
    
    public init(id: DTO.Model.ID) {
        self.path = "\(DTO.path)/\(id)"
    }
}


public struct SearchQueryTerm: Codable {
    /// The field to search on the server
    public var field: String
    /// How to search this field
    /// `==`, `~*`, `!=`, `contains`, etc
    public var comparator: String
    /// The text, or other type, to search for at the server
    public var searchText: String
}

public struct OrderByTerm: Codable {
    /// The field to `sort by`
    public var field: String
    /// Whether we're ascending or descending by this field
    public var acending: Bool
}

public struct GetAllSearchQuery: Codable {
    public var terms: [SearchQueryTerm]
    public var orderBy: OrderByTerm
}
