import Foundation

class UserDefaultsData: NSObject {
    private var defaults = UserDefaults()
    private var decoder = JSONDecoder()
    private var encoder = JSONEncoder()
    
    func store<T: Encodable>(key: String, data: T) -> Bool {
        do {
            let encoded = try encoder.encode(data)
            defaults.set(encoded, forKey: key)
            print("stored: \(encoded)\nfor key: \(key)")
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func read<T: Decodable>(key: String, forClass: T.Type) -> T? {
        if let data = defaults.object(forKey: key) as? Data {
            if let decoded = try? decoder.decode(forClass.self , from: data) {
                print(decoded)
                return decoded
            }
        }
        return nil
    }
}
