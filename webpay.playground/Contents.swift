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

var exponent: String? = nil
var modulus: String? = nil
var prefix: String? = nil

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

// GET /v2/merchant/{mId}/pay/key for the encryption information needed for the pay endpoint
var url = targetEnv + v2MerchantPath + merchantId + "/pay/key"
print("Requesting GET " + url)
print("Bearer " + accessToken)

var request = URLRequest(url: URL(string: url)!)
request.httpMethod = "GET"
request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")

URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
    let httpResponse = response as! HTTPURLResponse

    if httpResponse.statusCode == 200 {
        var jsonDictionary: NSDictionary? = nil

        do {
            jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
        } catch {
            print("JSON Serialization error")
        }

        if jsonDictionary != nil {
            exponent = jsonDictionary?.object(forKey: "exponent") as? String
            modulus = jsonDictionary?.object(forKey: "modulus") as? String
            prefix = jsonDictionary?.object(forKey: "prefix") as? String
            print(exponent!, modulus!, prefix!)
        }
    } else {
        print(httpResponse.statusCode)
        print("Read 'Troubleshooting common Clover REST API error codes' at https://medium.com/clover-platform-blog/troubleshooting-common-clover-rest-api-error-codes-9aaa8885373")
    }
}).resume()
