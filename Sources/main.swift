// The Swift Programming Language
// https://docs.swift.org/swift-book
// swift format -i Sources/*

import Cocoa

// Clase AppDelegate que maneja el ciclo de vida de la aplicación
class AppDelegate: NSObject, NSApplicationDelegate {
  var window: NSWindow!

  func applicationDidFinishLaunching(_ notification: Notification) {
    // Crear la ventana
    let screenSize = NSScreen.main?.frame.size ?? CGSize(width: 800, height: 600)
    let windowSize = CGSize(width: 400, height: 300)
    let windowRect = CGRect(
      x: (screenSize.width - windowSize.width) / 2,
      y: (screenSize.height - windowSize.height) / 2,
      width: windowSize.width,
      height: windowSize.height
    )

    window = NSWindow(
      contentRect: windowRect,
      styleMask: [.titled, .closable, .resizable, .miniaturizable],
      backing: .buffered,
      defer: false
    )
    window.title = "Mi Proyecto macOS"
    window.makeKeyAndOrderFront(nil)

    // Agregar un botón al centro de la ventana
    let button = NSButton(title: "Haz clic aquí", target: self, action: #selector(buttonClicked))
    button.frame = CGRect(
      x: (windowSize.width - 120) / 2,
      y: (windowSize.height - 30) / 2,
      width: 120,
      height: 30
    )
    window.contentView?.addSubview(button)
  }

  @objc func buttonClicked() {
    print("¡Botón presionado!")
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
