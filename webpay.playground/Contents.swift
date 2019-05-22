import Cocoa


// Configuration setup
let accessToken = ""
let merchantId = ""
let orderId = ""

// Clover's Sandbox environment
let targetEnv = "https://sandbox.dev.clover.com"
let v2MerchantPath = "/v2/merchant/"

// Example values
let amount = 1000
let tipAmount = 0
let taxAmount = 0
let cardNumber = "6011361000006668"
let expMonth = 12
let expYear = 2018
let cvv = 123
let zipCode = 94085


enum TestError: Error {
    case emptyAccesToken
    case emptyMerchantId
    case emptyOrderId
}

func configCheck() throws {
    if accessToken.isEmpty {
        throw TestError.emptyAccesToken
    }
    if merchantId.isEmpty {
        throw TestError.emptyMerchantId
    }
    if orderId.isEmpty {
        throw TestError.emptyOrderId
    }
}

do {
    try configCheck()
} catch TestError.emptyAccesToken {
    print("Remember to set your access_token with PROCESS_CARDS permission on line 13. For help creating an access_token, read https://docs.clover.com/clover-platform/docs/using-oauth-20")
} catch TestError.emptyMerchantId {
    print("Set your merchant ID, which can be found in your merchant dashboard: https://sandbox.dev.clover.com/developers")
} catch TestError.emptyOrderId {
    print("For help creating an order, read https://docs.clover.com/clover-platform/docs/working-with-orders")
}
