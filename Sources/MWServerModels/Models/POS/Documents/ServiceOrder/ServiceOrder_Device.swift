import Foundation

fileprivate typealias Device = ServiceOrder_DTO.V1.Device

extension Device {
    
    /// The model included in`ServiceOrder.devices`
    public struct Model: Codable, Identifiable, Hashable {
        /// The database ID of this device
        public var id: Int       
        
        public var createdAt: Date
        public var updatedAt: Date?
        
        /// The order in which this device appears in the list of devices
        public var listOrder: Int
        
        /// Which user created this device
        public var createdByUserName: String
        
        
        // MARK: Descriptors
        
        /// The manufacturer of this device: `Apple` `Samsung`
        public var manufacturer: String
        
        /// The model from this manufacturer: `MacBook Pro (13-inch, Late 2012)`
        public var model: String
        
        /// The serial number of this device
        public var serialNumber: String
        
        /// Is this repair a warranty repair?
        public var warranty: Bool
        
        /// What is the warranty information for this device
        public var warrantyInformation: String
        
        
        // MARK: Checkin notes
        /// A description of the initial state of the device
        public var vmi_initialPhysical: String
        
        /// A description of the state of the device from the technician
        public var vmi_technicianPhysical: String
        
        /// Any additional notes at checkin
        public var additionalNote: String
        
        public init(
            id: Int, createdAt: Date, updatedAt: Date?,
            listOrder: Int,
            createdByUserName: String,
            manufacturer: String, model: String, serialNumber: String,
            warranty: Bool, warrantyInformation: String,
            vmi_initialPhysical: String, vmi_technicianPhysical: String, additionalNote: String
        ) {
            self.id = id
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.listOrder = listOrder
            self.createdByUserName = createdByUserName
            self.manufacturer = manufacturer
            self.model = model
            self.serialNumber = serialNumber
            self.warranty = warranty
            self.warrantyInformation = warrantyInformation
            self.vmi_initialPhysical = vmi_initialPhysical
            self.vmi_technicianPhysical = vmi_technicianPhysical
            self.additionalNote = additionalNote
        }
    }
    
    
    /// Create a new `ServiceOrder_Device` at the server for a provided `ServiceOrder` parent model
    public struct CreateRequestModel: Codable {
        public var listOrder: Int
        public var manufacturer: String
        public var model: String
        public var serialNumber: String
        public var warranty: Bool
        public var warrantyInformation: String
        public var vmi_initialPhysical: String
        public var vmi_technicianPhysical: String
        public var additionalNote: String
        
        public init(
            listOrder: Int, 
            
            manufacturer: String, 
            model: String,
            serialNumber: String,
            
            warranty: Bool,
            warrantyInformation: String,
            
            vmi_initialPhysical: String,
            vmi_technicianPhysical: String,
            additionalNote: String
        ) {
            self.listOrder = listOrder
            self.manufacturer = manufacturer
            self.model = model
            self.serialNumber = serialNumber
            self.warranty = warranty
            self.warrantyInformation = warrantyInformation
            self.vmi_initialPhysical = vmi_initialPhysical
            self.vmi_technicianPhysical = vmi_technicianPhysical
            self.additionalNote = additionalNote
        }
    }
    
    public struct UpdateRequestModel: Codable {
        public var serviceOrderID: Int
    }
}
