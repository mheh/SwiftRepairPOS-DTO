import Foundation
import PhoneNumberKit

/// Be able to lookup the primary contact information for a contact model
public protocol PrimaryContactLookupProtocol {
    var phones: [PhoneNumber_DTO.V1.Model] { get set }
    var emails: [EmailAddress_DTO.V1.Model] { get set }
    var addresses: [StreetAddress_DTO.V1.Model] { get set }
}

extension PrimaryContactLookupProtocol {
    public func findPrimaryPhone(_ phoneNumbers: [PhoneNumber_DTO.V1.Model]) -> String {
        let phKit = PhoneNumberKit()
        var foundStr: String?
        if let found = phoneNumbers.first(where: { $0.primary}) {
            foundStr = "\(found.number)"
        } else if let found = phoneNumbers.first {
            foundStr = "\(found.number)"
        }
        
        guard let foundStr = foundStr  else { return "None" }
        do {
            let ph = try phKit.parse(foundStr)
            return phKit.format(ph, toType: .international)
        } catch {
            return foundStr
        }
    }

    public func findPrimaryEmail(_ emailAddresses: [EmailAddress_DTO.V1.Model]) -> String {
        var foundEmail: String?
        if let found = emailAddresses.first(where: { $0.primary }) {
            foundEmail = found.emailAddress
        }
        else if let found = emailAddresses.first {
            foundEmail = found.emailAddress
        }
        
        guard let foundEmail = foundEmail else { return "None" }
        return foundEmail
    }

    public func findPrimaryStreetAddress(_ streetAddresses: [StreetAddress_DTO.V1.Model]) -> String {
        var foundAddress: String?
        if let found = streetAddresses.first(where: {$0.primary }) {
            foundAddress = found.address1
        } else if let found = streetAddresses.first {
            foundAddress = found.address1
        }
        
        guard let foundAddress = foundAddress else { return "None" }
        return foundAddress
    }

}
