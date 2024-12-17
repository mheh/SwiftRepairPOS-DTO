import Foundation

/// The protocol for verifying whether communication can be made via email address, phone number, or street address.
public protocol ContactCommunicationProtocol {
    /// Whether this communication method is the primary
    var primary: Bool { get }
    /// Whether this communication method has been authorized by the contact
    var authed: Bool { get }
    /// Whether this communication method has been authorized for communication
    var authed_communication: Bool { get }
    /// Whether this communication method has been authorized for marketing
    var authed_marketing: Bool { get }
}

extension ContactCommunicationProtocol {
    /// Confirm we can send an update message (NOT MARKETING)
    func canSendUpdate() -> Bool {
        if self.authed && self.authed_communication {
            return true
        } else {
            return false
        }
    }
    
    /// Confirm we can send a marketing message
    func canSendMarketing() -> Bool {
        if self.authed && self.authed_marketing {
            return true
        } else {
            return false
        }
    }
}
