import Cocoa

class MainWindow: NSWindow {
  init(frame: NSRect) {
    super.init(
      contentRect: frame,
      styleMask: [.titled, .closable, .resizable, .miniaturizable],
      backing: .buffered,
      defer: false
    )

    // Configurar título y propiedades de la ventana
    self.title = "untitled - swMagnas"

    // Crear el StackView horizontal (fila superior)
    let topStackView = NSStackView()
    topStackView.orientation = .horizontal
    topStackView.alignment = .centerY
    topStackView.spacing = 10
    topStackView.distribution = .fill  // Evitar que el searchField se estire

    // Agregar elementos al StackView
    let leftTextField = NSTextField(labelWithString: "Izquierda")
    let centerSearchField = NSSearchField()
    let rightTextField = NSTextField(labelWithString: "Derecha")

    // Configurar dimensiones por defecto del NSSearchField
    centerSearchField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      centerSearchField.widthAnchor.constraint(
        equalToConstant: centerSearchField.intrinsicContentSize.width + 200),
      centerSearchField.heightAnchor.constraint(
        equalToConstant: centerSearchField.intrinsicContentSize.height),
    ])

    topStackView.addArrangedSubview(leftTextField)
    topStackView.addArrangedSubview(centerSearchField)
    topStackView.addArrangedSubview(rightTextField)

    // Añadir el StackView al contentView
    self.contentView?.addSubview(topStackView)

    // Configurar restricciones del StackView
    topStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topStackView.leadingAnchor.constraint(equalTo: self.contentView!.leadingAnchor, constant: 20),
      topStackView.trailingAnchor.constraint(
        equalTo: self.contentView!.trailingAnchor, constant: -20),
      topStackView.topAnchor.constraint(equalTo: self.contentView!.topAnchor, constant: 20),
    ])
  }
}
