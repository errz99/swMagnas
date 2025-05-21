import Cocoa

// Declarar una clase o estructura para contener variables globales
class GlobalState {
    @MainActor static var drawRect: Bool = false
}

class DrawingView: NSView {
    override func draw(_: NSRect) {
        // super.draw(dirtyRect)

        // Pintar el fondo
        let color = NSColor(red: 0.95, green: 0.88, blue: 0.80, alpha: 1.0)
        color.setFill()
        bounds.fill()

        if GlobalState.drawRect {
            drawRectangle()
        }
    }

    func drawRectangle() {
        // Crear un rectángulo en el centro del view
        let rectangle = NSRect(x: bounds.midX - 50, y: bounds.midY - 25, width: 100, height: 50)

        // Obtener el contexto gráfico
        guard let context = NSGraphicsContext.current?.cgContext else { return }

        // Configurar el color y dibujar el rectángulo
        context.setFillColor(NSColor.red.cgColor)
        context.fill(rectangle)

        // Forzar la actualización del view
        needsDisplay = true
    }
}

// Subclase de NSButton para deshabilitar el foco
class NonFocusableRadioButton: NSButton {
    override var acceptsFirstResponder: Bool {
        false // Evita que el radio button acepte el foco
    }
}

class MainWindow: NSWindow, NSWindowDelegate, NSSearchFieldDelegate {
    var radioButtonAll: NonFocusableRadioButton!
    var radioButtonDirs: NonFocusableRadioButton!
    var radioButtonFiles: NonFocusableRadioButton!
    var drawingView: DrawingView!
    var searchField: NSSearchField!

    init(frame: NSRect) {
        super.init(
            contentRect: frame,
            styleMask: [.titled, .closable, .resizable, .miniaturizable],
            backing: .buffered,
            defer: false
        )

        // Configura el delegado de la ventana
        delegate = self

        let sep: CGFloat = 10
        let textColor = NSColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1.0)

        // Configurar título y propiedades de la ventana
        title = "untitled - swMagnas"

        // Crear el StackView horizontal (fila superior)
        let topStackView = NSStackView()
        topStackView.orientation = .horizontal
        topStackView.alignment = .centerY
        topStackView.spacing = sep
        topStackView.distribution = .fillEqually

        // Crear un contenedor para los botones de radio
        let radioButtonContainer = NSStackView()
        radioButtonContainer.orientation = .horizontal
        radioButtonContainer.alignment = .centerY
        radioButtonContainer.spacing = sep

        // Crear los botones de radio
        radioButtonAll = NonFocusableRadioButton(radioButtonWithTitle: "All", target: nil, action: nil)
        radioButtonDirs = NonFocusableRadioButton(
            radioButtonWithTitle: "Dirs", target: nil, action: nil
        )
        radioButtonFiles = NonFocusableRadioButton(
            radioButtonWithTitle: "Files", target: nil, action: nil
        )

        // Agregar los botones de radio al contenedor
        radioButtonContainer.addView(radioButtonAll, in: .leading)
        radioButtonContainer.addView(radioButtonDirs, in: .leading)
        radioButtonContainer.addView(radioButtonFiles, in: .leading)

        // Configurar los radio buttons predeterminados
        radioButtonAll.state = .on // 'All' será seleccionado por defecto
        radioButtonDirs.state = .off
        radioButtonFiles.state = .off

        // Configurar acciones para los radio buttons
        radioButtonAll.target = self
        radioButtonAll.action = #selector(setStateForRadioButtons(_:))
        radioButtonDirs.target = self
        radioButtonDirs.action = #selector(setStateForRadioButtons(_:))
        radioButtonFiles.target = self
        radioButtonFiles.action = #selector(setStateForRadioButtons(_:))

        // Buscador
        searchField = NSSearchField()
        searchField.delegate = self
        searchField.alignment = .center
        searchField.target = self

        // Etiquetas de volumen
        let topRightTextField = NSTextField(labelWithString: "Derecha")
        topRightTextField.font = NSFont.systemFont(ofSize: 12)
        topRightTextField.textColor = textColor
        topRightTextField.alignment = .right

        // Configurar dimensiones por defecto del NSSearchField
        searchField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchField.widthAnchor.constraint(
                equalToConstant: searchField.intrinsicContentSize.width + 220),
            searchField.heightAnchor.constraint(
                equalToConstant: searchField.intrinsicContentSize.height)
        ])

        topStackView.addView(radioButtonContainer, in: .leading)
        topStackView.addView(searchField, in: .center)
        topStackView.addView(topRightTextField, in: .trailing)

        // Crear el StackView horizontal (fila inferior)
        let bottomStackView = NSStackView()
        bottomStackView.orientation = .horizontal
        bottomStackView.alignment = .centerY
        bottomStackView.spacing = sep
        bottomStackView.distribution = .fillEqually

        // Agregar views al StackView
        let bottomLeftTextField = NSTextField(labelWithString: "v0.0.1-20250518")
        bottomLeftTextField.font = NSFont.systemFont(ofSize: 11)
        bottomLeftTextField.alignment = .left
        let bottomCenterTextField = NSTextField(labelWithString: "0/0")
        bottomCenterTextField.font = NSFont.systemFont(ofSize: 11)
        bottomCenterTextField.alignment = .center
        let bottomRightTextField = NSTextField(labelWithString: "on:")
        bottomRightTextField.font = NSFont.systemFont(ofSize: 11)
        bottomRightTextField.textColor = textColor
        bottomRightTextField.alignment = .right

        bottomStackView.addView(bottomLeftTextField, in: .leading)
        bottomStackView.addView(bottomCenterTextField, in: .center)
        bottomStackView.addView(bottomRightTextField, in: .trailing)

        // Crear vista de dibujo
        drawingView = DrawingView()

        // Crear el StackView vertical
        let verticalStackView = NSStackView()
        verticalStackView.orientation = .vertical
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        // Añadir el StackView al contentView
        verticalStackView.addView(topStackView, in: .top)
        verticalStackView.addView(drawingView, in: .center)
        verticalStackView.addView(bottomStackView, in: .bottom)

        // Añadir el StackView al contentView
        contentView?.addSubview(verticalStackView)
        // Configurar el foco inicial en searchField
        contentView?.window?.makeFirstResponder(searchField)

        // Configurar restricciones del StackView (top)
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(
                equalTo: contentView!.leadingAnchor, constant: sep
            ),
            topStackView.trailingAnchor.constraint(
                equalTo: contentView!.trailingAnchor, constant: -sep
            ),
            topStackView.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: sep)
        ])

        // Configurar restricciones del StackView (bottom)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomStackView.leadingAnchor.constraint(
                equalTo: contentView!.leadingAnchor, constant: sep
            ),
            bottomStackView.trailingAnchor.constraint(
                equalTo: contentView!.trailingAnchor, constant: -sep
            ),
            bottomStackView.bottomAnchor.constraint(
                equalTo: contentView!.bottomAnchor, constant: -sep
            )
        ])
    }

    // Método del delegado que responde al evento de redimensionar
    func windowDidResize(_: Notification) {
        let width = Int(frame.size.width)
        let height = Int(frame.size.height)

        if height % 50 == 0 {
            print("Dimensiones de la ventana - Width: \(width), Height: \(height)")
        }
    }

    // Sobrescribir el método keyDown para capturar eventos de teclado
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 53: // escape
            GlobalState.drawRect = false
            drawingView.setNeedsDisplay(drawingView.bounds)
            makeFirstResponder(searchField)
        case 122: // F1
            activateRadioButton(radioButtonAll)
        case 120: // F2
            activateRadioButton(radioButtonDirs)
        case 99: // F3
            activateRadioButton(radioButtonFiles)
        default:
            // print("key code: \(event.keyCode)")
            super.keyDown(with: event) // Pasar otros eventos al sistema
        }
    }

    // Activar el radio button especificado
    private func activateRadioButton(_ button: NonFocusableRadioButton) {
        setStateForRadioButtons(button)
        button.performClick(nil) // Simular un clic en el botón
    }

    // Método para manejar el cambio de estado de los radio buttons
    @objc func setStateForRadioButtons(_ sender: NonFocusableRadioButton) {
        // Desactivar todos los botones primero
        radioButtonAll.state = .off
        radioButtonDirs.state = .off
        radioButtonFiles.state = .off

        // Activar únicamente el botón seleccionado
        sender.state = .on
    }

    // Método delegado para capturar eventos del teclado en searchField
    func control(_ control: NSControl, textView _: NSTextView, doCommandBy commandSelector: Selector)
        -> Bool {
        if control == searchField, commandSelector == #selector(NSResponder.insertNewline(_:)) {
            // La tecla Return ha sido presionada
            handleSearchFieldReturn(searchField)
            return true // Consumimos el evento para evitar que otros lo procesen
        }
        return false // Permitir que otros eventos se procesen normalmente
    }

    // Método para manejar la acción de Return en searchField
    @objc func handleSearchFieldReturn(_: NSSearchField) {
        makeFirstResponder(drawingView)

        // Forzar redibujado de drawingView
        GlobalState.drawRect = true
        drawingView.setNeedsDisplay(drawingView.bounds)
    }
}
