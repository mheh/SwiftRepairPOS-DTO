# MWServer-Models
API communication models for the frontend communication to backend MWServer


## Example Frontend Usage
### Declaration of Server Configuration
```swift
class UserConfigurationClass {
  var serverConfiguration: MWServerConfiguration
  
  init(serverConfiguration: MWServerConfiguration) {
    self.serverConfiguration = serverConfiguration
  }
}
```
### Creating a URLRequest with MW model
Take provided information from the frontend interaction and generate a request object
```swift
// Somewhere globally MWServerConfiguration defined 
let loginRequest = Auth_DTO.Login.init(body: Auth_DTO.Login.Body(email: "test@test.com", password: "test"))
let request = try globalServerConfig.createAPIURLRequest(model: loginRequest)
```
### Decoding response type
This should be wrapped in a function that checks model.response? is defined.
Here it's evil with force unwrap
```swift
// earlier, let loginRequest = Auth_DTO.Login.init(...)
let resp = try JSONDecoder().decode(loginRequest.response!, from: data)
```

## Example Backend Usage
### Database Model -> API Response
Providing API model to frontend response
```swift
// somewhere in code
final class Customer: Model {}

// MARK: API Model Response Initializer
extension MWCustomer.V1.Model {
  /// Create this model from our database model
  init(from customer: Customer) throws {
    self.id = try customer.requireID()
    self.firstName = customer.firstName
    self.lastName = customer.lastName
    /// etc
  }
}
```
### API Request -> Database Model
For something like a POST request, when we need to create something from provided information
```swift
final class Customer: Model {}

// MARK: Database Model POST Request Initializer
extension Customer {
  init(from apiReq: MWCustomer.V1.Create.Request) {
    self.firstName = apiReq.firstName
    self.lastName = apiReq.lastName
  }
}
```
