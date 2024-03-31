//
//  Network.swift
//  TicketSasaIOS
//
//  Created by Samuel Nyamai on 30/03/2024.
//

import Foundation


class Network: ObservableObject {
    @Published var users: [User] = []
//    @Published var users: [String] = []
    @Published var errorResponse: ErrorResponse?
    @Published var loginResponse: LoginResponse?
    @Published var eventListResponse: EventList?
//    @Published var eventList: [Event] = []
    
    
    func getUsers(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest){(data, response, error) in
            if let error = error{
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode([User].self, from: data)
                        self.users = decodedUsers
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIxNTI2MSJ9.RriIqS941ciVeSiQinOai-BzeXVvfeV-jKT5nb5IHTc"
    
    func getEventData(){
        guard let url = URL(string: "https://www.ticketsasa.com/index.php?option=com_enmasse&controller=MobileEvents&task=getEvents") else { fatalError("Missing URL") }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest){(data, response, error) in
            

            if let error = error{
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedEvents = try JSONDecoder().decode(EventList.self, from: data)
                        self.eventListResponse = decodedEvents
//                        self.eventList = decodedEvents.events
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    
    func getPostString(params:[String:Any]) -> String
      {
          var data = [String]()
          for(key, value) in params
          {
              data.append(key + "=\(value)")
          }
          return data.map { String($0) }.joined(separator: "&")
      }
    
    func login(email:String, password:String){
        guard let url = URL(string: "https://www.ticketsasa.com/index.php?option=com_users&task=MobileUser.login") else { fatalError("Missing URL") }
        var urlRequest = URLRequest(url: url)

        let bodyRequest = LoginRequest(username: "samuel@pesapal.com", password: "Future")
        let body: [String: Any] = [
            "username": email,
            "password": password,
        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) // pass dictionary to data object and set it as request body
  
        urlRequest.httpMethod = "POST"
//        urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        urlRequest.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//        urlRequest.httpBody = jsonData
        
    
        let postString = self.getPostString(params: body)
        urlRequest.httpBody = postString.data(using: .utf8)

        let dataTask = URLSession.shared.dataTask(with: urlRequest){(data, response, error) in
          
            print("-----> data: \(data)")
            print("-----> data2: ", urlRequest.httpBody)
            
            
            print("-----> error: \(error)")
            print("-----> response is: \(response)")
            
                             
            if let error = error{
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            print("-----> status code is: \(response.statusCode)")
            
    
//            if let json = try JSONSerialization.jsonObject(with: data!) as? [[String:Any]] {
//                for item in json {
//                    if let size = item["error"] as? [String:Any] {
//                        print(size)
//                    }
//                }
//            }
            
//            do  {
//                    let Json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                    guard let newValue = Json as? [[String: Any]],
//                        let size = newValue[0]["error_message"] as? [String:Any] else {
//                            return
//                    }
//                    print("Size is ",size)
//                }
//                catch {
//                    print("Response Not Found.")
//                }
            
            if response.statusCode == 200 {
                
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        self.errorResponse = decodedError
                    } catch let error {
                        print("Error decoding: ", error)
                        //if error contains "stringValue: "error"  then it a success Error decoding:  keyNotFound(CodingKeys(stringValue: "error", in
                        do{
                            let decodedUsers = try JSONDecoder().decode(LoginResponse.self, from: data)
                            self.loginResponse = decodedUsers
                        }
                        catch let error {
                            print("Error second decoding: ", error)
                            //if error contains "stringValue: "error"  then it a success Error decoding:  keyNotFound(CodingKeys(stringValue: "error", in
                         
                        }
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
