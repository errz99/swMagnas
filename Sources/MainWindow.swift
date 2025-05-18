import Cocoa

class MainWindow: NSWindow {
  init() {
    // Tamaño y posición de la ventana
    let screenSize = NSScreen.main?.frame.size ?? CGSize(width: 800, height: 600)
    let windowSize = CGSize(width: 400, height: 300)
    let windowRect = CGRect(
      x: (screenSize.width - windowSize.width) / 2,
      y: (screenSize.height - windowSize.height) / 2,
      width: windowSize.width,
      height: windowSize.height
    )

    // Configuración de la ventana
    super.init(
      contentRect: windowRect,
      styleMask: [.titled, .closable, .resizable, .miniaturizable],
      backing: .buffered,
      defer: false
    )

    self.title = "Mi Proyecto macOS"

    // Agregar botón al centro de la ventana
    let button = NSButton(title: "Haz clic aquí", target: self, action: #selector(buttonClicked))
    button.frame = CGRect(
      x: (windowSize.width - 120) / 2,
      y: (windowSize.height - 30) / 2,
      width: 120,
      height: 30
    )
    self.contentView?.addSubview(button)
  }

  @objc func buttonClicked() {
    print("¡Botón presionado!")
  }
}
