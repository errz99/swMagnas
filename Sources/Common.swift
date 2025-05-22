import Cocoa

// Declarar una clase o estructura para contener variables globales
class GlobalState {
    static let appNameForTitle: String = " - swMagnas"

    @MainActor static var mainWindow: MainWindow? = nil
    @MainActor static var configChanged: Bool = false
    @MainActor static var dataChanged: Bool = false
    @MainActor static var drawRect: Bool = false
}

extension String {
    func trimSpaces() -> String {
        trimmingCharacters(in: .whitespaces)
    }
}
