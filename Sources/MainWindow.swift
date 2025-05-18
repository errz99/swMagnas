import Cocoa

class DrawingView: NSView {
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)

    // Pintar el fondo de color verde
    let color = NSColor.init(red: 0.95, green: 0.90, blue: 0.85, alpha: 1.0)
    color.setFill()
    bounds.fill()
  }
}

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
    leftTextField.alignment = .left
    let centerSearchField = NSSearchField()
    centerSearchField.alignment = .center
    let rightTextField = NSTextField(labelWithString: "Derecha")
    rightTextField.alignment = .right

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

    // Crear el StackView horizontal (fila inferior)
    let bottomStackView = NSStackView()
    bottomStackView.orientation = .horizontal
    bottomStackView.alignment = .centerY
    bottomStackView.spacing = 10
    bottomStackView.distribution = .fill  // Evitar que el searchField se estire

    // Agregar elementos al StackView
    let leftTextField2 = NSTextField(labelWithString: "Izquierda")
    leftTextField2.alignment = .left
    let centerTextField = NSTextField(labelWithString: "Center")
    centerTextField.alignment = .center
    let rightTextField2 = NSTextField(labelWithString: "Derecha")
    rightTextField2.alignment = .right

    bottomStackView.addArrangedSubview(leftTextField2)
    bottomStackView.addArrangedSubview(centerTextField)
    bottomStackView.addArrangedSubview(rightTextField2)

    // Crear vista de dibujo
    let drawingView = DrawingView()

    // Crear el StackView vertical
    let verticalStackView = NSStackView()
    verticalStackView.orientation = .vertical
    verticalStackView.translatesAutoresizingMaskIntoConstraints = false

    // Añadir el StackView al contentView
    verticalStackView.addArrangedSubview(topStackView)
    verticalStackView.addArrangedSubview(drawingView)
    verticalStackView.addArrangedSubview(bottomStackView)

    // // Añadir el StackView al contentView
    self.contentView?.addSubview(verticalStackView)

    // Configurar restricciones del StackView (top)
    topStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topStackView.leadingAnchor.constraint(equalTo: self.contentView!.leadingAnchor, constant: 10),
      topStackView.trailingAnchor.constraint(
        equalTo: self.contentView!.trailingAnchor, constant: -10),
      topStackView.topAnchor.constraint(equalTo: self.contentView!.topAnchor, constant: 10),
    ])

    // Configurar restricciones del StackView (bottom)
    bottomStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bottomStackView.leadingAnchor.constraint(
        equalTo: self.contentView!.leadingAnchor, constant: 10),
      bottomStackView.trailingAnchor.constraint(
        equalTo: self.contentView!.trailingAnchor, constant: -10),
      bottomStackView.bottomAnchor.constraint(
        equalTo: self.contentView!.bottomAnchor, constant: -10),
    ])
  }
}
