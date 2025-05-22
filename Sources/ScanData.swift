import Cocoa

struct OneFile {
    var name: String
    var nameLow: String
    // var line: String
    // var path: String
    var len: UInt64 = 0

    init(name: String, len: UInt64) {
        self.name = name
        nameLow = name.lowercased()
    }
}

struct OneDir {
    var name: String
    var nameLow: String
    // var path: String
    var len: UInt64 = 0

    init(name: String) {
        self.name = name
        nameLow = name.lowercased()
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

    init(_ name: String, _ path: String, _ flist: String) {
        self.name = name
        self.path = path
    }
}

class ScanData: Codable {
    var volumes: [OneVolume]

    init() {
        volumes = []
    }

    // Guardar scan data en un archivo JSON
    func save(url: URL) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            try data.write(to: url)
            print("Datos guardados en: \(url.absoluteString)")
        } catch {
            print("Error al guardar los datos: \(error)")
        }
    }

    // Cargar la configuración desde un archivo JSON
    static func load(url: URL) -> ScanData? {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(ScanData.self, from: data)
        } catch {
            print("No se pudieron cargar los datos: \(error)")
            return nil
        }
    }
}
