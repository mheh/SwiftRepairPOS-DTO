import Foundation

/// User models and interaction requests
public struct User_DTO {
    public enum V1 {}
}
fileprivate typealias V1 = User_DTO.V1

extension V1: MWDTO_CRUDModel {
    
    public static var path: String = "users"
    
    
    
    
    
    
    /// User model returned from server
    public struct Model: Codable, Identifiable, Hashable, Sendable {
        /// System user's UUID
        public var id: UUID
        
        /// System user's username
        public var username: String
        
        /// System user's name
        public var fullname: String
        
        /// System user's email
        public var email: String
        
        /// System user's permissions
        public var permissions: UserPermissions
        
        /// System user's admin ability
        public var isAdmin: Bool
        
        /// Whether this user can login or not
        public var isActive: Bool
        
        /// Whether this user has been reset
        public var isReset: Bool
        
        public init (
            id: UUID,
            username: String,
            fullname: String,
            email: String,
            permissions: UserPermissions,
            isAdmin: Bool,
            isActive: Bool,
            isReset: Bool
        ) {
            self.id = id
            self.username = username
            self.fullname = fullname
            self.email = email
            self.permissions = permissions
            self.isAdmin = isAdmin
            self.isActive = isActive
            self.isReset = isReset
        }
    }
    
    
    
    
    
    /// The model to create a new user on the server
    /// The returned `Model` will be a reset user
    public struct CreateRequestModel: Codable, Sendable {
        
        /// Username
        public var username: String
        
        /// Full name of the user
        public var fullname: String
        
        /// Email address of user
        public var email: String
        
        /// password
        public var password: String
        
        /// confirm password
        public var confirmPassword: String
        
        /// The permissions of the user
        public var permissions: UserPermissions
        
        public init (
            username: String,
            fullname: String,
            email: String,
            password: String,
            confirmPassword: String,
            permissions: UserPermissions
        ) {
            self.username = username
            self.fullname = fullname
            self.email = email
            self.password = password
            self.confirmPassword = confirmPassword
            self.permissions = permissions
        }
    }
    
    
    
    
    
    
    /// The model to perform update requests on a user
    public struct UpdateRequestModel: Codable, Sendable {
        
        /// Changing their username?
        public var username: String?
        
        /// Changing their name?
        public var fullname: String?
        
        /// Users email address
        public var email: String?
        
        /// Are we trying to make them an admin?
        public var isAdmin: Bool?
        
        /// Are we trying to reset the user?
        public var isReset: Bool?
        
        /// Is the user currently active?
        public var isActive: Bool?
        
        
        
        
        
        
        public init (
            username: String? = nil,
            fullname: String? = nil,
            email: String? = nil,
            isAdmin: Bool? = nil,
            isReset: Bool? = nil,
            isActive: Bool? = nil
        ) {
            self.username = username
            self.fullname = fullname
            self.email = email
            self.isAdmin = isAdmin
            self.isReset = isReset
            self.isActive = isActive
        }
    }
    
    
    
    
    
    
    /// Update a users password
    public struct UpdatePasswordModel: Codable, Sendable {
        /// New password
        public var password: String
        /// Confirm new password
        public var confirmPassword: String
        
        public init(password: String, confirmPassword: String) {
            self.password = password
            self.confirmPassword = confirmPassword
        }
    }
    
    
    
    
    
    /// Model for updating a user's permissions
    public struct UpdatePermissionsRequestModel: Codable, Sendable {
        
        /// Users permission
        public var permissions: UserPermissions
        
        public init(permissions: UserPermissions) {
            self.permissions = permissions
        }
    }
}






// MARK: - User Permissions

extension V1 {
    
    /// Various user permissions for different routes/actions. Passed in the JWT token.
    public struct UserPermissions: Codable, Hashable, Sendable {
        
        /// Permission settings for editing `User` models
        public var users: UserPermissions_User
        
        /// Permission settings for editing `Product` models`
        public var products: UserPermissions_Product
        
        /// Permission settings for editing `LineItem` models
        public var lineItems: UserPermissions_LineItem
        
        /// Permission settings for editing `Server Settings`
        public var settings: UserPermissions_ServerSettings
        
        
        
        
        /// Default initializer
        public init(users: UserPermissions_User, products: UserPermissions_Product, lineItems: UserPermissions_LineItem, settings: UserPermissions_ServerSettings) {
            self.users = users
            self.products = products
            self.lineItems = lineItems
            self.settings = settings
        }
        
        /// Initialize for empty empty permissions
        public init() {
            self.users = .init([])
            self.products = .init([])
            self.settings = .init([])
            self.lineItems = .init([])
        }
        
        
        
        
        // MARK: Hashable Conformance
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(users.rawValue)
            hasher.combine(products.rawValue)
            hasher.combine(settings.rawValue)
        }
        
        public static func == (lhs: UserPermissions, rhs: UserPermissions) -> Bool {
            return lhs.users == rhs.users && lhs.products == rhs.products && lhs.settings == rhs.settings
        }
    }
    
    
    
    
    
    
    // MARK: - User Permissions for `User` routes
    
    /// Permissions for `User` routes
    public struct UserPermissions_User: OptionSet, Codable, Sendable {
        public let rawValue: Int64

        
        // MARK: C
        
        /// Can create a new user
        public static let user_create = UserPermissions_User(rawValue: 1 << 0 )
        
        
        
        
        
        // MARK: R
        
        /// Read all information about other users in the system, the sensitive details >:D
        public static let user_read_others = UserPermissions_User(rawValue: 1 << 1)
        
        
        
        
        
        
        // MARK: U
        
        /// Can change their own contact information
        public static let user_update_self = UserPermissions_User(rawValue: 1 << 2)
        
        /// Can edit other `User` information. If the user with this permission is **NOT** an admin they're still restricted that way.
        public static let user_update_others = UserPermissions_User(rawValue: 1 << 3)
        
        /// Can reset other `User` accounts
        public static let user_update_resetOthers = UserPermissions_User(rawValue: 1 << 4)
        
        
        
        
        // MARK: D
        
        /// Can delete a user
        public static let user_delete = UserPermissions_User(rawValue: 1 << 5)
        
        
        
        
        
        // MARK: Administrator
        
        /// Can manage users: `edit, create, delete`
        public static let administrator: UserPermissions_User = [
            // MARK: C
            .user_create,
            // MARK: R
            .user_read_others,
            // MARK: U
            .user_update_self,
            .user_update_others,
            .user_update_resetOthers,
            // MARK: D
            .user_delete
        ]
        
        
        
        // MARK: Initializers
        
        public init(rawValue: Int64) {
            self.rawValue = rawValue
        }
        
        public init(_ permissions: UserPermissions_User) {
            self = permissions
        }
    }
    
    
    
    
    
    
    // MARK: - User Permissions for `Product` routes
    
    /// Permissions for `Product` routes
    public struct UserPermissions_Product: OptionSet, Codable, Sendable {
        public let rawValue: Int64
        
        // MARK: C
        
        /// Can create a new product
        public static let product_create = UserPermissions_Product(rawValue: 1 << 0 )
       
        /// Can create a new product cost
        public static let product_create_cost = UserPermissions_Product(rawValue: 1 << 1)
        
        /// Can create all types of `Product` records
        public static let product_createManager: UserPermissions_Product = [
            .product_create,
            .product_create_cost
        ]
        
        
        // MARK: R
       
        
        // MARK: U
        
        /// Can edit a product record **GENERAL**
        public static let product_update = UserPermissions_Product(rawValue: 1 << 2)
        
        /// Can edit the `product.productDescription` field
        public static let product_update_description = UserPermissions_Product(rawValue: 1 << 3)
        
        /// Can edit the `product.sellPrice` field
        public static let product_update_sellPrice = UserPermissions_Product(rawValue: 1 << 4)
        
        /// Can edit `ProductCost` models for a product
        public static let product_update_cost = UserPermissions_Product(rawValue: 1 << 5)
        
        /// Can edit `Product` model boolean fields: `serialized`, `inventoried`, etc
        public static let product_update_bools = UserPermissions_Product(rawValue: 1 << 6)
        
        /// Can edit all product information
        public static let product_updateManager: UserPermissions_Product = [
            .product_update,
            .product_update_description,
            .product_update_sellPrice,
            .product_update_cost,
            .product_update_bools
        ]
        
        
        
        
        
        
        // MARK: D
        
        /// Can delete a `Product` record
        public static let product_delete = UserPermissions_Product(rawValue: 1 << 7)
        
        /// Can delete a `ProductCost` record
        public static let product_delete_cost = UserPermissions_Product(rawValue: 1 << 8)
        
        /// Can delete all types of `Product` records
        public static let product_deleteManager: UserPermissions_Product = [
            .product_delete,
            .product_delete_cost
        ]
        
        
        
        
        
        // MARK: Administrator
        
        /// Can manage all product information
        public static let administrator: UserPermissions_Product = [
            // MARK: C
            .product_createManager,
            // MARK: R
            // MARK: U
            .product_updateManager,
            // MARK: D
            .product_deleteManager
        ]
        
        
        
        // MARK: Initializers
        
        public init(rawValue: Int64) {
            self.rawValue = rawValue
        }
        
        public init(_ permissions: UserPermissions_Product) {
            self = permissions
        }
    }
    
    
    
    
    
    
    // MARK: - User Permissions for `Server Settings` routes
    
    /// Permissions for `Server Settings` routes
    public struct UserPermissions_ServerSettings: OptionSet, Codable, Sendable {
        public let rawValue: Int64
        
        // MARK: C
        
        /// Can create a new `ServerSetting` entry: `Tax` `Currency` `DocumentFooter`
        public static let serverSetting_create = UserPermissions_ServerSettings(rawValue: 1 << 0 )
        
        
        
        
        
        
        // MARK: R
        
        /// Can read all server settings
        public static let serverSetting_read_allSettings = UserPermissions_ServerSettings(rawValue: 1 << 1)
        
        /// Can read all `GSX` settings
        public static let serverSetting_read_GSX = UserPermissions_ServerSettings(rawValue: 1 << 2)
        
        /// Can read all `Ingram Micro` settings
        public static let serverSetting_read_ingramMicro = UserPermissions_ServerSettings(rawValue: 1 << 3)
        
        
        
        
        
        // MARK: U
        
        /// Can edit a `ServerSetting` **GENERAL**
        public static let serverSetting_update_allSettings = UserPermissions_ServerSettings(rawValue: 1 << 4)
        
        /// Can update the `GSX` communication settings
        public static let serverSetting_update_GSX = UserPermissions_ServerSettings(rawValue: 1 << 5)
        
        /// Can update the `Ingram Micro` communication settings
        public static let serverSetting_update_IngramMicro = UserPermissions_ServerSettings(rawValue: 1 << 6)
        
        
        
        
        
        // MARK: D
        
        /// Can delete a `ServerSetting`
        public static let serverSetting_delete = UserPermissions_ServerSettings(rawValue: 1 << 7)
        
        
        
        
        
        // MARK: Roles
        /// Can manage all `GSX` settings
        public static let gsxAdmin: UserPermissions_ServerSettings = [
            .serverSetting_read_GSX,
            .serverSetting_update_GSX
        ]
        
        /// Can manage all `Ingram Micro` settings
        public static let ingramMicroAdmin: UserPermissions_ServerSettings = [
            .serverSetting_read_ingramMicro,
            .serverSetting_update_IngramMicro
        ]
        
        
        
        
        
        // MARK: Administrator
        
        /// Can manage all server settings
        public static let administrator: UserPermissions_ServerSettings = [
            // MARK: C
            .serverSetting_create,
            // MARK: R
            .serverSetting_read_allSettings,
            // MARK: U
            .serverSetting_update_allSettings,
            // MARK: D
            .serverSetting_delete
        ]
        
        
        
        
        
        
        // MARK: Initializers
        
        public init(rawValue: Int64) {
            self.rawValue = rawValue
        }
        
        public init(_ permissions: UserPermissions_ServerSettings) {
            self = permissions
        }
    }
    
    
    
    
    
    
    // MARK: User Permissions for `LineItem` routes/actions
    
    /// Permissions for `LineItem` routes/actions
    public struct UserPermissions_LineItem: OptionSet, Codable, RawRepresentable, Sendable {
        public let rawValue: Int64
        
        // MARK: C
        
        /// Can create a new `LineItem` on a saved document after being posted
        public static let lineItem_create_afterPosted = UserPermissions_LineItem(rawValue: 1 << 0)
        
        
        // MARK: R
        
        
        // MARK: U
        
        /// Can edit a `LineItem`
        public static let lineItem_update = UserPermissions_LineItem(rawValue: 1 << 1)
        
        /// Can edit the `productDescription` of a `LineItem`
        public static let lineItem_update_productDescription = UserPermissions_LineItem(rawValue: 1 << 2)
        
        /// Can edit the `sellPrice` of a `LineItem`
        public static let lineItem_update_sellPrice = UserPermissions_LineItem(rawValue: 1 << 3)
        
        /// Can edit the assignment of `Commissionable` line items.
        public static let lineItem_update_commissionable = UserPermissions_LineItem(rawValue: 1 << 4)
        
        
        // MARK: After Document Posting
        
        /// Can edit the `quantity` of a `LineItem` after the document was posted
        public static let lineItem_update_quantityAfterPosted = UserPermissions_LineItem(rawValue: 1 << 5)
        
        /// Can edit the `serialNumbers` of a `LineItem` after the document was posted
        public static let lineItem_update_serialNumbersAfterPosted = UserPermissions_LineItem(rawValue: 1 << 6)
        
        
        
        
        
        
        // MARK: D
        
        /// Can delete a `LineItem` before or after being posted
        public static let lineItem_delete = UserPermissions_LineItem(rawValue: 1 << 7)
        
        
        
        
        
        // MARK: Administrator
        
        /// Can manage all `LineItem` records
        public static let administrator: UserPermissions_LineItem = [
            // MARK: C
            .lineItem_create_afterPosted,
            // MARK: R
            // MARK: U
            .lineItem_update,
            .lineItem_update_productDescription,
            .lineItem_update_sellPrice,
            .lineItem_update_commissionable,
            .lineItem_update_quantityAfterPosted,
            .lineItem_update_serialNumbersAfterPosted,
            // MARK: D
            .lineItem_delete
        ]
        
        
        
        
        // MARK: Initializers
        
        public init(rawValue: Int64) {
            self.rawValue = rawValue
        }
        
        public init(_ permissions: UserPermissions_LineItem) {
            self = permissions
        }
    }
}




// MARK: - MWRequestProtocol Custom Implementations

extension V1 {
    /// Update the permissions for the provided `userID`
    public struct UpdatePermissionsRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .PUT
        
        public var body: Encodable?
        public var response: Decodable.Type? = Model.self
        
        public init(userID: UUID, permissions: UpdatePermissionsRequestModel) {
            self.path = "\(V1.path)/\(userID)/permissions"
            self.body = permissions
        }
    }
    
    
    /// Fetch the currently authenticated user
    public struct GetCurrentUser: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .GET
        
        public var body: Encodable? = nil
        public var response: Decodable.Type? = Model.self
        
        public init() {
            self.path = "\(V1.path)/current"
        }
    }
    
    
    /// Fetch a list of all users
    public struct GetAllUsersRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .GET
        
        public var body: Encodable? = nil
        public var response: Decodable.Type? = [Model].self
        
        public init() {
            self.path = "\(V1.path)"
        }
    }
    
    /// Update the password for an existing user
    public struct UpdatePasswordRequest: MWRequestProtocol {
        public var path: String
        public var urlQueryParams: [String : String] = [:]
        public var requestType: MWRequest_HTTPType = .PUT
        
        public var body: Encodable?
        public var response: Decodable.Type? = Model.self
        
        public init(userID: UUID, body: UpdatePasswordModel) {
            self.path = "\(V1.path)/\(userID)/password"
            self.body = body
        }
    }
}
