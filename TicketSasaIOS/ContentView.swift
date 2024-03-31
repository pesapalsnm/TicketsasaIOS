//
//  ContentView.swift
//  Ticketsasa
//
//  Created by Samuel Nyamai on 20/03/2024.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @EnvironmentObject var network: Network
    
    // todo https://designcode.io/swiftui-advanced-handbook-http-request
    // https://developer.apple.com/documentation/swiftui/navigation
    // Tab view
    
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-push-a-new-view-when-a-list-row-is-tapped
    
    @State private var email:String = ""
    @State private var password:String = ""

    // LOGIN LOGIC
    
//    var body: some View{
//        VStack (alignment: .center){
//            Image("ticketsasa_logo")
//                .imageScale(.small)
//                .foregroundStyle(.tint)
//            TextField("Email Address", text: $email)
//                .autocorrectionDisabled()
//                .autocapitalization(.none)
//            TextField("Password", text: $password)
//                .autocorrectionDisabled()
//                .autocapitalization(.none)
//            Button(action: {
//                network.login(email: email, password: password)
//
//            }) {
////                Label("Sign In", systemImage: "arrow.up")
//                Text("Sign In")
//                .font(Font.custom("Arial", size: 20))
//                .kerning(3)
//                .multilineTextAlignment(.center)
//                .foregroundColor(.white)
//            }.background(Color.black)
//            Text("Forgot Password?")
//                .font(.callout)
//            
//            
//            VStack(alignment: .leading) {
//                Text("Hardcoded Token")
//                Text(network.errorResponse?.errorMessage ?? "Empty error")
//                Text(network.loginResponse?.token ?? "No token")
//                
//            }
//            
//        }
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//        .background(Color.red)
//        .onAppear{
//            
//            
//        }
//        
//    
//    }
    

    // FETCHING EVENTS
        var body: some View {
            ScrollView {
                    Text("All Events")
                    .font(.title).bold()

                VStack(alignment: .leading) {
                    ForEach(network.eventListResponse?.events ?? []) { user in
                        HStack(alignment:.top) {
//                            Text("\(user.id)")
                            Text("Thur \n 14th \n 2024")


                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .bold()

                                Text(user.location)

                                Text("\(user.startDate)")

                            }
                        }
                        .frame(width: 300, alignment: .leading)
                        .padding()
                        .background(Color(#colorLiteral(red: 0.6667672396, green: 0.7527905703, blue: 1, alpha: 0.2662717301)))
                        .cornerRadius(20)
                    }
                }
            }
            .onAppear {
                    network.getEventData()
            }
    }
    

    // EXAMPLE
    // On clicking the event it could use this
//    var body: some View {
//            ScrollView {
//                    Text("All users")
//                    .font(.title).bold()
//                
//                VStack(alignment: .leading) {
//                    ForEach(network.users) { user in
//                        HStack(alignment:.top) {
//                            Text("\(user.id)")
//
//                            VStack(alignment: .leading) {
//                                Text(user.name)
//                                    .bold()
//
//                                Text(user.email.lowercased())
//
//                                Text(user.phone)
//                            }
//                        }
//                        .frame(width: 300, alignment: .leading)
//                        .padding()
//                        .background(Color(#colorLiteral(red: 0.6667672396, green: 0.7527905703, blue: 1, alpha: 0.2662717301)))
//                        .cornerRadius(20)
//                    }
//                }
//            }
//            .onAppear {
//                    network.getUsers()
//            }
//    }
    
    

    
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
        .environmentObject(Network())
}
