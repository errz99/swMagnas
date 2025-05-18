import Cocoa

class MainWindow: NSWindow {
  init() {
    // Tamaño y posición inicial de la ventana
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

    // Crear el botón
    let button = NSButton(title: "Haz clic aquí", target: self, action: #selector(buttonClicked))
    button.translatesAutoresizingMaskIntoConstraints = false  // Habilitar Auto Layout
    self.contentView?.addSubview(button)

    // Configurar restricciones para mantener el botón centrado
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: self.contentView!.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: self.contentView!.centerYAnchor),
    ])
  }

  @objc func buttonClicked() {
    print("¡Botón presionado!")
  }
}
