//
//  AboutMeView.swift
//  GitHub API
//
//  Created by Guilherme Ferreira Lenzolari on 18/07/23.
//

import Foundation
import SwiftUI

struct AboutMeView: View {
    
    @State private var user: GitHubUser?
    
    var body: some View {

        
        VStack(spacing: 25) {


            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) {image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 180, height: 180)
            .padding(.top, 40)
            
            VStack{
                Text(user?.login ?? "Username")
                    .bold()
                    .font(.title)
                Text(user?.name ?? "Name")
                    .foregroundColor(.gray)
            }
            
            Text(user?.bio ?? "Bio")
            
            VStack(spacing: 10){
                                
                HStack{
                    Text("🏢")
                    Text(user?.company ?? "Company")
                }

                HStack{
                    Text("📍")
                    Text(user?.location ?? "City")
                }
            }

            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getUser()
            } catch GHError.invalidURL {
                print("invalid URL")
            } catch GHError.invalidResponse {
                print("invalid Response")
            } catch GHError.invalidData {
                print("invalid Data")
            } catch {
                print("unexpected error")
            }
        }
    }
    
    
    //API request
    func getUser() async throws -> GitHubUser{
        
        let endpoint = "https://api.github.com/users/guilenzolari"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL}
                
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
}

//erros
enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
