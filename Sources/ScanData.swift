import Cocoa

struct OneFile: Codable {
    var name: String
    // var nameLow: String
    // var line: String
    // var path: String
    var len: UInt64 = 0

    init(name: String, len: UInt64) {
        self.name = name
    }
}

struct OneDir: Codable {
    var name: String
    // var nameLow: String
    // var path: String
    var len: UInt64 = 0

    init(name: String) {
        self.name = name
    }
}

class OneFolder: Codable {
    var name: String
    // var line: String
    var numDirs: UInt64 = 0
    var numFiles: UInt64 = 0
    // var updTime: String
    var dirsFiltered: UInt64 = 0
    var filesFiltered: UInt64 = 0

    init(volName: String, name: String) {
        self.name = name
    }
}

class OneVolume: Codable {
    var name: String
    var path: String
    var folderList: String = ""
    var folders: [OneFolder] = []
    var active: Bool = true
    var visible: Bool = true
    var string: String = ""
    var dirsFiltered: UInt64 = 0
    var filesFiltered: UInt64 = 0

    init(name: String, path: String, flist: String) {
        self.name = name
        self.path = path
    }
}

class ScanData: Codable {
    var volumes: [OneVolume] = []

    // Guardar scan data en un archivo JSON
    func save(path: String) {
        do {
            let dataPath = URL(fileURLWithPath: path)
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            try data.write(to: dataPath)
            print("Configuración guardada en: \(dataPath)")
        } catch {
            print("Error al guardar la configuración: \(error)")
        }
    }

    // Cargar la configuración desde un archivo JSON
    static func load(path: String) -> ScanData? {
        do {
            let dataPath = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: dataPath)
            let decoder = JSONDecoder()
            return try decoder.decode(ScanData.self, from: data)
        } catch {
            print("No se pudo cargar la configuración: \(error)")
            return nil
        }
    }
}
