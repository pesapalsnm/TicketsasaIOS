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
    
    //todo https://designcode.io/swiftui-advanced-handbook-http-request
    
    @State private var email:String = ""
    @State private var password:String = ""

    
    var body: some View{
        VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
            Image("ticketsasa_logo")
                .imageScale(.small)
                .foregroundStyle(.tint)
            TextField("Email Address", text: $email)
            TextField("Password", text: $email)
            Button(action: {
                
            }) {
                Label("Sign In", systemImage: "arrow.up")
            }
            Text("Forgot Password?")
            
            VStack(alignment: .leading) {
                Text(network.errorResponse?.errorMessage ?? "Empty error")
                Text(network.loginResponse?.token ?? "No token")
                
            }
            
        } .background(Color.red)
            .onAppear {
                             network.login()
                     }
        
    
    }
    
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
