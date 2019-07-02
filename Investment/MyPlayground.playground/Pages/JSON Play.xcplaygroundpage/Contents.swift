import UIKit
import SwiftUI
/*
private func readAssets() -> [Asset] {
    let path = Bundle.main.path(forResource: "content", ofType: "plist")
    print(path ?? "")
    var contentsArray = [Asset]()
    if let path = path {
        if let contentsXML = FileManager.default.contents(atPath: path) {
            do {
                let plistData = try PropertyListSerialization.propertyList(from: contentsXML, options: [], format: nil)
                contentsArray = plistData as! Array
            } catch {
                NSLog("Error when decoding contents from \(path)")
            }
        }
    }
    return contentsArray
}

print(readAssets()[0].name)
*/
struct Asset : Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var lifetime: Int           // in years
    var isDepreciable: Bool     // non Depreciable assets are expences forming Working Capital
    var value: Int
}

//  Create data to be parsed to JSON and saved
let assets = [
    Asset(name: "Selling Price", description: "Asked or estimated price", lifetime: 5, isDepreciable: true, value: 280000),
    Asset(name: "All Additions", description: "Furniture, Kitchen, Structural, Renovation, etc", lifetime: 5, isDepreciable: true, value: 157000),
    Asset(name: "Services", description: "Real estate agent graphic designer, web, PR (openning), etc", lifetime: 3, isDepreciable: true, value: 8800),
    Asset(name: "Bureaucracy", description: "Notary, company registration, etc", lifetime: 3, isDepreciable: true, value: 6700),
    Asset(name: "Rent Deposit", description: "", lifetime: 0, isDepreciable: false, value: 7700),
    Asset(name: "Max Cumulative Loss", description: "Estimated peak cummulative loss to be finaced by investment", lifetime: 0, isDepreciable: false, value: 47600),
    Asset(name: "Extra Working Capital", description: "\"Buffer\"", lifetime: 0, isDepreciable: false, value: 25000)
]

func encodeJSONDataToString(data: Codable) -> String? {
    
    //  Encode data as JSON
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    do {
        let jsonData = try encoder.encode(assets)
        
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            //  print(jsonString)
            print("ура, JSON получился!")
            return jsonString
        } else {
            return nil
        }
    } catch {
        print(error.localizedDescription)
        return nil
    }
}

func writeJSON(jsonString: String, filename: String) {
  
    let fileNameWithExtension = filename + ".json"
    
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(fileNameWithExtension)

        print("dir:     \(dir)")
        print("fileURL: \(fileURL)")

        do {
            let tryResult = try jsonString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            print("jsonString.write try result: \(tryResult)\n")
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            print(error.localizedDescription)
        }
    } else {
        print("error: не создается dir")
    }
}

if let jsonString = encodeJSONDataToString(data: assets) {
    writeJSON(jsonString: jsonString, filename: "Assets")
}


func readJSONfromFile() {
    //  https://www.hackingwithswift.com/example-code/language/how-to-use-codable-to-load-and-save-custom-data-types
    //  https://www.hackingwithswift.com/read/7/3/parsing-json-using-the-codable-protocol
}

let encoder = JSONEncoder()
let jsonData = try encoder.encode(assets)
let decoder = JSONDecoder()
let assetsFromJSON = try decoder.decode([Asset].self, from: jsonData)
//print("актив #0: \(assetsFromJSON[0])")

func parse(data: Data) -> [Asset]? {
    do {
        let decoder = JSONDecoder()
        let result = try decoder.decode([Asset].self, from:data)
        return result
    } catch {
        print("JSON Error: \(error)")
        return nil
    }
}




//  https://www.swiftbysundell.com/posts/constructing-urls-in-swift
//  StaticString is the lesser-known "cousin" of the main String type. The main difference between the two is that StaticString can't be the result of any dynamic expression - such as string interpolation or concatenation - the whole string needs to be defined as an inline literal. Internally, Swift uses this type for things like collecting file names for assertions and preconditions, but we can also use this type to create a URL initializer for completely static URLs - like this:

extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        
        self = url
    }
}
//  At first, doing something like the above might seem to go against Swift's idea of runtime safety, but there's a good reason why we want to cause a crash here rather than dealing with optionals.

//  Like we took a look at in "Picking the right way of failing in Swift", what kind of error handling that's appropriate for any given case depends a lot on whether the error is caused by a programmer mistake or an execution error. Since defining an invalid static URL is definitely a programmer mistake, using a preconditionFailure is most likely the best fit for the problem. With handling like that in place, we'll get a clear indication of what went wrong, and since we're now using a dedicated API for static URLs, we can even add linting and static checks to make things even more safe.

//With the above in place, we can now easily define non-optional URLs using a static string literal:

let url = URL(staticString: "https://www.dropbox.com/s/jec7gizgousolik/Assets.json?dl=1")


func dropboxAssetsURL() -> URL? {   //  https://www.swiftbysundell.com/posts/constructing-urls-in-swift
    guard let url = URL(staticString: "https://www.dropbox.com/s/jec7gizgousolik/Assets.json?dl=1") else {
        print("error creating URL from string")
        return nil
    }
    print("dropboxAssetsURL: \(url)\n")
    
    return url
}




/*
func dataFromFile(/* ??? cloudKitURL: String */) -> Data {
}

// return data from local JSON file is there is one with data
func dataFromFile(filename: String) -> Data? {
    guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
        print("no \(filename).json file on disk at Bundle.main.path")
        return nil
    }
    print("path: \(path)")
 
    guard let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
//        catch {}
        print("error in getting data fron file contents")
        return nil
    }
 
    return jsonData
}
 */

enum NetworkError: Error {
    case badURL
    case notFound   //  404
}


func dataFromFileDropbox(from urlString: String,
                       completionHandler: @escaping (Result<Data, NetworkError>) -> Void)  {
    guard let url = URL(string: urlString) else {
        return completionHandler(.failure(.badURL))
    }
    
    // complicated networking code here
    print("Fetching \(url.absoluteString)...")
    completionHandler(.failure(.notFound))
    completionHandler(.success(data))
}

dataFromFileDropbox(from: "https://www.dropbox.com/…") { result in
    switch result {
    case .success(let data):
        print("GO AHEAD!")
//        return data
    case .failure(let error):
        switch error {
        case .badURL:
            print("bad URL: \(error.localizedDescription)")
        case .notFound:
            print("file not found: \(error.localizedDescription)")
        }
    }
}



//  return data from JSON file at Dropbox is there is one with data
func dataFromFileDropbox(at dropboxURL: String) -> Data? {
    var dataToReturn: Data?
    
    guard let url = URL(string: dropboxURL) else {
        print("error creating URL from string")
        return nil
    }
    print("dropboxAssetsURL: \(url)\n")
    
    
    let dataTask = URLSession.shared.dataTask(with: url) {
        data, response, error in
        
        DispatchQueue.main.async {
            if let error = error {  // error is not nil
                print("Failure! \(error.localizedDescription)")
                return
            }
            print("из Dropbox что-то вынулось, но что?")
            
            //  MARK: HANDLE RESPONSE CODE 200, 404 AND OTHER
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                
                guard statusCode == 200 else {
                    if statusCode == 404 {  // 404 = Not Found
                        print("File Not Found: response statusCode = \(statusCode)")
                    } else {
                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
                            print("data: \(dataString)")
                        }
                        print("с файлом по url'у что-то не так, response statusCode = \(statusCode)")
                    }
                    
                    return nil
                }
                
                // 200 = OK
                print("good to go (response statusCode = \(statusCode))")
                
                dataToReturn = data
                
                //  GUARD: was there any data returned?
                guard let data = data else {
                    print("No data was returned by the request!")
                }
            }
        }
    }
    dataTask.resume()
    
    return dataToReturn
}

//  return data from JSON file at Dropbox is there is one with data
//  using ideas from https://www.swiftbysundell.com/posts/using-tokens-to-handle-async-swift-code
func dataFromFileDropboxNEW(at dropboxURL: String) -> Data? {
    var dataToReturn: Data?
    
    guard let url = URL(string: dropboxURL) else {
        print("error creating URL from string")
    }
    print("dropboxAssetsURL: \(url)\n")
    
    
    let dataTask = URLSession.shared.dataTask(with: url) {
        data, response, error in
        
        DispatchQueue.main.async {
            if let error = error {  // error is not nil
                print("Failure! \(error.localizedDescription)")
                return
            }
            print("из Dropbox что-то вынулось, но что?")
            
            //  MARK: HANDLE RESPONSE CODE 200, 404 AND OTHER
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                
                guard statusCode == 200 else {
                    if statusCode == 404 {  // 404 = Not Found
                        print("File Not Found: response statusCode = \(statusCode)")
                    } else {
                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
                            print("data: \(dataString)")
                        }
                        print("с файлом по url'у что-то не так, response statusCode = \(statusCode)")
                    }
                }
                
                // 200 = OK
                print("good to go (response statusCode = \(statusCode))")
                
                dataToReturn = data
                
                //  GUARD: was there any data returned?
                guard let data = data else {
                    print("No data was returned by the request!")
                }
            }
        }
    }
    dataTask.resume()
    
    return dataToReturn
}

if let data = dataFromFileDropboxNEW(at: "https://www.dropbox.com/s/jec7gizgousolik/Assets.json?dl=1") {
    if let parsedData = parse(data: data) {
        print("первый элемент массива из файла на Dropbox: \(parsedData[0])")
    }
}

/*

???? dataFromFileDropbox(dropboxURL: "https://www.dropbox.com/s/jec7gizgousolik/Assets.json?dl=1")

if let parsedData = parse(data: data) {
    print("первый элемент массива из файла на Dropbox: \(parsedData[0])")
}


guard let data = dataFromFile(filename: "Assets") else {
    print("error getting data from local file")
}

var data: Data
if data = dataFromFile("Assets") {
    //parse data
} else if data = dataFromFile(dropboxURL: String) {
    
} else {
}


let dropboxURL = "https://dropbox.com/…"
/*if let data = dataFromFile() {
 parse()
 } else if let data = dataFromFile(dropboxURL: dropboxURL) {
 parse()
 }*/

guard var data = dataFromFile(dropboxURL: dropboxURL) else {
    print("no data in Dropbox file")
}
guard var data = dataFromFile() else {
    print("no data in local file")
}
parse()
*/



/*

if let path = Bundle.main.path(forResource: "Assets", ofType: "json") {
    do {
        print("path: \(path)")
        let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        if let ass = parse(data: jsonData) {
            print("первый элемент массива из файла на диске: \(ass[0])")
        }
    } catch {
        // handle error
//        print(error.localizedDescription)
    }
} else {
    print("no Assets.json file on disk at Bundle.main.path")

    getDataFromJSONatDropbox()
}


func getDataFromJSONatDropbox() {
    guard let url = dropboxAssetsURL() else {
        print("Failed to construct URL")
    }

    let dataTask = URLSession.shared.dataTask(with: url) {
        data, response, error in
        
        DispatchQueue.main.async {
            if let error = error {
                print("Failure! \(error.localizedDescription)")
                return
            }
            print("из Dropbox что-то вынулось, но что?")
        
            //  MARK: HANDLE RESPONSE CODE 200, 404 AND OTHER
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                
                guard statusCode == 200 else {
                    if statusCode == 404 {  // 404 = Not Found
                        print("File Not Found: response statusCode = \(statusCode)")
                    } else {
                        print("с файлом по url'у что-то не так, response statusCode = \(statusCode)")
                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
                            print("data: \(dataString)")
                        }
                    }
                    return
                }
                
                // 200 = OK
                print("good to go (response statusCode = \(statusCode))")
            }
        
            //  GUARD: was there any data returned?
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
        
            if let parsedData = parse(data: data) {
                print("первый элемент массива из файла на Dropbox: \(parsedData[0])")
            }
        }
    }
    dataTask.resume()
}
*/



func getDataFromJSONatDropbox() -> Data {
    var dataToReturn: Data
    
    guard let url = dropboxAssetsURL() else {
        print("Failed to construct URL")
    }
    
    let dataTask = URLSession.shared.dataTask(with: url) {
        data, response, error in
        
        DispatchQueue.main.async {
            if let error = error {
                print("Failure! \(error.localizedDescription)")
                return
            }
            print("из Dropbox что-то вынулось, но что?")
            
            //  MARK: HANDLE RESPONSE CODE 200, 404 AND OTHER
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                
                guard statusCode == 200 else {
                    if statusCode == 404 {  // 404 = Not Found
                        print("File Not Found: response statusCode = \(statusCode)")
                    } else {
                        print("с файлом по url'у что-то не так, response statusCode = \(statusCode)")
                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
                            print("data: \(dataString)")
                        }
                    }
                    return
                }
                
                // 200 = OK
                print("good to go (response statusCode = \(statusCode))")
            }
            
            //  GUARD: was there any data returned?
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }

            dataToReturn = data
            
            if let parsedData = parse(data: data) {
                print("первый элемент массива из файла на Dropbox: \(parsedData[0])")
            }
        }
    }
    dataTask.resume()
    
    return dataToReturn
}
