import Cocoa

// Clase AppDelegate que maneja el ciclo de vida de la aplicación
class AppDelegate: NSObject, NSApplicationDelegate {
  var mainWindow: MainWindow!

  func applicationDidFinishLaunching(_ notification: Notification) {
    // Crear e inicializar la ventana principal
    mainWindow = MainWindow()
    mainWindow.makeKeyAndOrderFront(nil)
  }

  func applicationWillTerminate(_ notification: Notification) {
    // Código para limpiar recursos si es necesario
  }
}

// Configuración de la aplicación
let app = NSApplication.shared
NSApp.setActivationPolicy(.regular)
let delegate = AppDelegate()
app.delegate = delegate
app.run()
