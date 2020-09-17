//
//  ContentView.swift
//  simple-weather
//
//  Created by Elizabeth Luu on 9/16/20.
//  Copyright © 2020 Elizabeth Luu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    func getWeather(zipcode: String, completion: @escaping ([String:Any]) -> Void) {
        let urlOpt = URL(string: "")
        guard let url = urlOpt else {
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error in guard error == nil else {
                return
            }
           
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: mutableContainers as? [String:Any])
            }
            catch let error {
                print(error)
            }
        })
        task.resume()
    }
        
    
    @State var zipcode = ""
    @State var cityName = "Austin"
    @State var temperature = "90";
    
    func updateWeather() {
        getWeather(zipcode: self.zipcode, completion: {json in print(json)
            if let cityName = json["name"]
                as? String {
                    self.cityName = cityName
                }
                
            if let main = json["main"] as? [String:Double] {
                if let temperature = main["temp"] {
                    self.temperature = String(format: "%.2f", temperature)
                }
            }
            
        })
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Simple Weather App")
                    .font(.title)
                TextField("Zipcode", text: $zipcode)
            }
            Button(action: {updateWeather}) {
                Text("Look up weather")
            }
            Spacer()
            if weatherLoaded {
                VStack {
                    Text("Weather in " + cityName)
                    Text("Temperature: " + temperature)
                }
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
