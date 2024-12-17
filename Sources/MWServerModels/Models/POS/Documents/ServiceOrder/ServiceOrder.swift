import Foundation

/// Models used to represent a Service Order
public struct ServiceOrder_DTO {
    public enum V1 {
        /// The master  `ServiceOrder` model
        public struct Document {}
        /// `ServiceOrderDevice`s associated with a model
        public struct Device {}
        /// The status of `ServiceOrder`
        public struct Status {}
    }
}

fileprivate typealias Document = ServiceOrder_DTO.V1.Document


extension Document: MWDTO_CRUDModel {
    /// The path to access `ServiceOrder` models
    public static var path: String = "serviceorders"
    
    /// The model returned from the server for a `ServiceOrder`
    public struct Model: Codable, Identifiable, Hashable {
        public var id: Int
        public var serviceOrderID: String
        
        public var createdAt: Date
        public var updatedAt: Date?
        public var deletedAt: Date?
        
        /// The devies associated with this `ServiceOrder`
        public var devices: [ServiceOrder_DTO.V1.Device.Model]
        
        /// A description of what the order is for
        public var problemDescription: String
        
        /// The status of this `ServiceOrder`
        public var status: ServiceOrder_DTO.V1.Status.ResponseModel
        
        /// The `Base` model associated with this `ServiceOrder`
        public var base: Base_DTO.V1.Document.Model
        
        public init(
            id: Int, serviceOrderID: String,
            createdAt: Date, updatedAt: Date? = nil, deletedAt: Date? = nil,
            devices: [ServiceOrder_DTO.V1.Device.Model],
            problemDescription: String,
            status: ServiceOrder_DTO.V1.Status.ResponseModel,
            base: Base_DTO.V1.Document.Model
        ) {
            self.id = id
            self.serviceOrderID = serviceOrderID
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.deletedAt = deletedAt
            self.devices = devices
            self.problemDescription = problemDescription
            self.status = status
            self.base = base
        }
    }
    
    
    /// Create a new `ServiceOrder` from supplied information
    public struct CreateRequestModel: Codable {
        /// The devices to track on this `ServiceOrder`
        public var devices: [ServiceOrder_DTO.V1.Device.CreateRequestModel]
        
        /// The description of the issue for this `ServiceOrder`
        public var problemDescription: String
        
        /// The status to assign this `ServiceOrder`
        /// if none is provided, the default one is chosen when created
        public var status: ServiceOrder_DTO.V1.Status.Model?
        
        /// The base information for this `ServiceOrder`
        public var base: Base_DTO.V1.Document.CreateRequestModel
        
        public init(
            devices: [ServiceOrder_DTO.V1.Device.CreateRequestModel], 
            problemDescription: String,
            status: ServiceOrder_DTO.V1.Status.Model? = nil,
            base: Base_DTO.V1.Document.CreateRequestModel
        ) {
            self.devices = devices
            self.problemDescription = problemDescription
            self.status = status
            self.base = base
        }
    }
    
    public struct UpdateRequestModel: Codable {
        public var customerID: String?
    }
}


// MARK: V1 AdvancedSearchableProtocol
extension Document: AdvancedSearchableProtocol {
    public typealias AllFields = ServiceOrderFields
    
    public enum ServiceOrderFields: String, Codable, CaseIterable, Identifiable{
        public var id: String { self.rawValue }
        
        case ServiceOrderID = "Service Order ID"
        case ContactID = "Contact ID"
        case DeviceSerialNumber = "Device Serial Number"
    }
    
}

