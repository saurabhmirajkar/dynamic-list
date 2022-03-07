//
//  ListItem.swift
//  DynamicList
//
//  Created by Saurabh Mirajkar on 06/03/22.
//

import Foundation

struct ListItem {
    var StationId : String
    var StationName : String
    var Logo : String
}

class ListParser: NSObject, XMLParserDelegate {
    
    private var listItems : [ListItem] = []
    private var currentElement : String = ""
    
    private var currentStationId : String = "" {
        didSet {
            currentStationId = currentStationId.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    private var currentStationName : String = "" {
        didSet {
            currentStationName = currentStationName.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    private var currentLogo : String = "" {
        didSet {
            currentLogo = currentLogo.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    private var parserCompletionHandler : (([ListItem]) -> Void)?
    
    func parseList(url: String, completionHandler: (([ListItem]) -> Void)?) {
        self.parserCompletionHandler = completionHandler
        
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }

            // parse our xml data
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
        }
        
        task.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "Item" {
            currentStationId = ""
            currentStationName = ""
            currentLogo = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "StationId": currentStationId += string
        case "StationName": currentStationName += string
        case "Logo": currentLogo += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Item" {
            let listItem = ListItem(StationId: currentStationId, StationName: currentStationName, Logo: currentLogo)
            self.listItems.append(listItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.parserCompletionHandler?(listItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
}
