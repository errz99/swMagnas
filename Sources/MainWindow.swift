import Cocoa

class DrawingView: NSView {
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)

    // Fondo verde SOLO dentro del área de esta vista
    NSColor.green.setFill()
    bounds.fill()  // Usa bounds para limitar el color al área de la vista

    // Dibujo de un rectángulo
    let rect = NSRect(x: 20, y: 20, width: 100, height: 50)
    NSColor.blue.setFill()
    rect.fill()

    // Dibujo de una línea
    let path = NSBezierPath()
    path.move(to: NSPoint(x: 150, y: 20))
    path.line(to: NSPoint(x: 250, y: 70))
    NSColor.red.setStroke()
    path.lineWidth = 2
    path.stroke()

    // Dibujo de texto
    let text = "Hola, mundo"
    let attributes: [NSAttributedString.Key: Any] = [
      .font: NSFont.systemFont(ofSize: 14),
      .foregroundColor: NSColor.black,
    ]
    text.draw(at: NSPoint(x: 20, y: 80), withAttributes: attributes)
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

    self.title = "Mi Proyecto macOS"

    // Crear NSGridView
    let gridView = NSGridView()
    gridView.translatesAutoresizingMaskIntoConstraints = false
    gridView.rowSpacing = 10
    gridView.columnSpacing = 10

    // Crear componentes de la primera fila
    let leftTextField1 = NSTextField(labelWithString: "Izquierda")
    let centerSearchField = NSSearchField()
    let rightTextField1 = NSTextField(labelWithString: "Derecha")

    // Crear componentes de la segunda fila
    let leftTextField2 = NSTextField(labelWithString: "Izquierda")
    let centerTextField2 = NSTextField(labelWithString: "Centro")
    let rightTextField2 = NSTextField(labelWithString: "Derecha")

    // Crear la vista para dibujo
    let drawingView = DrawingView()
    drawingView.translatesAutoresizingMaskIntoConstraints = false

    // Añadir filas al grid
    gridView.addRow(with: [leftTextField1, centerSearchField, rightTextField1])
    gridView.addRow(with: [drawingView])  // Fila de la vista para dibujo
    gridView.addRow(with: [leftTextField2, centerTextField2, rightTextField2])

    // Configurar alineación de las columnas
    gridView.column(at: 0).xPlacement = .leading  // Alinear a la izquierda
    gridView.column(at: 1).xPlacement = .center  // Alinear al centro
    gridView.column(at: 2).xPlacement = .trailing  // Alinear a la derecha

    // Configurar restricciones dinámicas para las filas
    gridView.row(at: 0).yPlacement = .top  // Primera fila anclada arriba
    gridView.row(at: 2).yPlacement = .bottom  // Última fila anclada abajo
    gridView.row(at: 1).yPlacement = .fill  // DrawingView ocupa el espacio restante

    // Configurar la vista principal
    self.contentView?.addSubview(gridView)

    // Restringir el gridView para que se ajuste dinámicamente al tamaño de la ventana
    NSLayoutConstraint.activate([
      gridView.leadingAnchor.constraint(equalTo: self.contentView!.leadingAnchor, constant: 10),
      gridView.trailingAnchor.constraint(equalTo: self.contentView!.trailingAnchor, constant: -10),
      gridView.topAnchor.constraint(equalTo: self.contentView!.topAnchor, constant: 10),
      gridView.bottomAnchor.constraint(equalTo: self.contentView!.bottomAnchor, constant: -10),
    ])
  }
}
