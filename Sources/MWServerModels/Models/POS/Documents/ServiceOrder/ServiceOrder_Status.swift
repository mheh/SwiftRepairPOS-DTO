import Foundation

fileprivate typealias Status = ServiceOrder_DTO.V1.Status

extension Status: MWDTO_CRUDModel {
    public static var path: String = "serviceorders/statuses"
    
    /// A status for a `ServiceOrder`
    public struct Model: Codable, Identifiable, Hashable {
        public var id: UUID
        public var listOrder: Int
        
        public var status: String
        public var color: Color
        
        public init(id: UUID, listOrder: Int, status: String, color: Color) {
            self.id = id
            self.listOrder = listOrder
            self.status = status
            self.color = color
        }
    }
    
    /// The model used when sending the parent `ServiceOrder` model
    public struct ResponseModel: Codable, Hashable {
        public var status: String
        public var color: Color
        
        public init(status: String, color: Color) {
            self.status = status
            self.color = color
        }
    }
    
    /// Create a new status for a `ServiceOrder`
    public struct CreateRequestModel: Codable {
        public var status: String
        public var listOrder: Int
        public var color: Color
        
        public init(status: String, listOrder: Int, color: Color) {
            self.status = status
            self.listOrder = listOrder
            self.color = color
        }
    }
    
    public typealias UpdateRequestModel = CreateRequestModel
    
    /// Colors for a `ServiceOrder status`
    public enum Color: String, Codable {
        case red, green, yellow, blue, gray
    }
}
