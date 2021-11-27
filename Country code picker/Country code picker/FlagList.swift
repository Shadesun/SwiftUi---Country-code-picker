//
//  FlagList.swift
//  Country code picker
//
//  Created by Shadesun on 27/11/2021.
//

import SwiftUI

import SwiftUI

struct Country: Codable, Hashable {
    var name: String
    var dialCode: String
    var isoCode: String
    init () {
        name = "France"
        dialCode = "+33"
        isoCode = "FR"
    }
}

// get the flag emoji with given country ISO code
func countryFlag(countryCode: String) -> String {
  return String(String.UnicodeScalarView(
     countryCode.unicodeScalars.compactMap({ UnicodeScalar(127397 + $0.value) })))
}

// load country list from json (placement of the json file doesn't matter if using xcode)
func getCountryList() -> [Country] {
        let url = Bundle.main.url(forResource: "countries", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let products = try? decoder.decode([Country].self, from: data)
        return products!
}

struct FlagList: View {
    @State private var searchText: String = ""
    @Binding var showModal: Bool
    @Binding var selectedCountry: Country
    @Binding var selectedCode: String
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search")
            List {
                // filter elements from the loaded array according to searchBar value
                ForEach(getCountryList().filter {
                    self.searchText.isEmpty ? true : $0.name.lowercased().contains(self.searchText.lowercased()) ||
                        $0.dialCode.lowercased().contains(self.searchText.lowercased())
                }, id: \.self) {item in
                    Button(action: {
                        // selection handle, changes values and closes the modal
                        selectedCountry = item
                        selectedCode = item.dialCode
                        showModal = false
                    }) {
                        // Display elements in list
                        Text("\(countryFlag(countryCode: item.isoCode)) \(item.name) : \(item.dialCode)")
                    }
                }
            }
        }
    }
}
