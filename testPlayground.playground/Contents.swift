import Cocoa
import Foundation


struct Urls {
    static let areYoutheAuthorURL = URL(string: "")!
    static let recommentedArticleURL = URL(string: "https://datafloq.com/account/plugin/?plugin_tab=recommended")!
    static let faqURL = URL(string: "https://datafloq.com/plugin/faq/")!
    static let privacyURL = URL(string: "https://datafloq.com/privacy/")!
    static let termsURL = URL(string: "https://datafloq.com/terms/")!
    static let thisIsArticle = URL(string:"https://datafloq.com/account/login/?next=/plugin/report-as-article/%3Furl%3Dhttps%3A//stackoverflow.com/questions/29433487/create-an-nsalert-with-swift")!
    static let baseURL = "https://sayone-6qua.localhost.run"//"http://192.168.0.6:8000"//"https://datafloq.com"
}


struct Path {
    static let login = "/api/plugin/v1/login/"
    static let logout = "/api/plugin/v1/logout"
    static let pluginAuthenticated = "/api/plugin/v1/get-is-authenticated"
    static let articleScore = "/api/plugin/v1/article-score/"
    static let manualRating = "/api/plugin/v1/manual-rating"
}

let session: URLSession = {
    let config = URLSessionConfiguration.default
    //           config.timeoutIntervalForResource = 3
    //           config.timeoutIntervalForRequest = 3
    let session = URLSession(configuration: config)
    return session
}()


struct LoginResponseModel: Codable {
    let username, csrf: String?
    let success: Bool?
    let error: Error?
}

// MARK: - Error
struct Error: Codable {
    let username, password, all: [String]?

    enum CodingKeys: String, CodingKey {
        case username, password
        case all = "__all__"
    }
}


func loginCheckApi(username: String, password: String) {
       
        let parameterDictionary = ["username" : username, "password" : password]
               let url = URL(string: Urls.baseURL+Path.login)!
    print("url: \(Urls.baseURL+Path.login)")
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
   
               guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                   return
               }
               request.httpBody = httpBody
       request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
       
       let task = session.dataTask(with: request) { (data, response, error) -> Void in
           

           let httpResponse = response as? HTTPURLResponse
            print("hello response: \(String(describing: response))")
           
           if error == nil && httpResponse?.statusCode == 200  {
                  
            print(String(data: data!, encoding: .utf8)!)
               do {
                let loginResponse = try JSONDecoder().decode(LoginResponseModel.self, from: data!)
                print("x: \(loginResponse.success)")
               } catch {
                   print("Failed to decode JSON")
               }
               
           }
           else {
               print("\n\n loginCheck2 catch response error : \n \(String(describing: error))")
//
           }
       }
       task.resume()
   }

loginCheckApi(username: "gokul.sayone@gmail.com", password: "password")



