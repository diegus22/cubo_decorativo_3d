// =============================================================================
//  llavero.scad — Llavero 3D personalizable con texto y aro
//  Diego García / Ingeniatic — 2026
//
//  Genera un llavero MANIFOLD (cuerpo único, sin huecos parásitos), listo
//  para imprimir en FDM/SLA. Texto extruido sobre placa con agujero para aro.
//
//  Editar las variables del PARAMS y dar a F6 (Render) → Export STL.
//  Desde CLI:
//      openscad -o LORETO.stl -D 'TEXT="LORETO"' llavero.scad
// =============================================================================

// ─────────── PARAMS ───────────
TEXT          = "LORETO";    // Palabra/letras que aparecen en el llavero
FONT          = "Liberation Sans:style=Bold";  // Fuente. Otras: "Arial Black", "Courier New:style=Bold"
TEXT_SIZE     = 18;          // Altura nominal de las letras (mm)
TEXT_HEIGHT   = 5;           // Profundidad/extrusión de las letras (mm)

PLATE_HEIGHT  = 3;           // Espesor de la placa base (mm)
PLATE_PADDING = 6;           // Margen alrededor del texto sobre la placa (mm)
PLATE_RADIUS  = 5;           // Redondeo de las esquinas de la placa (mm)

RING_DIAM     = 6;           // Diámetro del agujero para el aro (mm). 5–8 típico.
RING_OFFSET   = 4;           // Distancia del agujero al borde izquierdo (mm)

LETTER_SPACING = 1.05;       // Multiplicador de avance entre letras (≥ 1.0 evita solapes)

$fn = 64;                    // Resolución de los círculos (más alto = más fino, más lento)

// ─────────── INTERNAL ───────────
// Aproximación de bounding box del texto (Liberation Sans Bold ~ 0.62×size por glifo)
GLYPH_W = TEXT_SIZE * 0.62 * LETTER_SPACING;
TEXT_W  = len(TEXT) * GLYPH_W;
TEXT_H  = TEXT_SIZE * 0.85;

// Placa: alto = texto + 2*padding ; ancho = texto + 2*padding + RING_OFFSET + RING_DIAM
PLATE_W = TEXT_W + 2*PLATE_PADDING + RING_OFFSET + RING_DIAM + 4;
PLATE_H = TEXT_H + 2*PLATE_PADDING;

module rounded_plate(w, h, t, r) {
    hull() {
        translate([r,       r,       0]) cylinder(h=t, r=r);
        translate([w - r,   r,       0]) cylinder(h=t, r=r);
        translate([r,       h - r,   0]) cylinder(h=t, r=r);
        translate([w - r,   h - r,   0]) cylinder(h=t, r=r);
    }
}

module keychain() {
    union() {
        // 1. Placa base con aro
        difference() {
            rounded_plate(PLATE_W, PLATE_H, PLATE_HEIGHT, PLATE_RADIUS);
            // Agujero del aro a la izquierda, vertical centrado
            translate([RING_OFFSET + RING_DIAM/2, PLATE_H/2, -1])
                cylinder(h=PLATE_HEIGHT + 2, d=RING_DIAM);
        }

        // 2. Texto extruido encima de la placa, alineado a derecha del aro
        translate([RING_OFFSET + RING_DIAM + 4, PLATE_PADDING, PLATE_HEIGHT])
            linear_extrude(height=TEXT_HEIGHT)
                text(TEXT, size=TEXT_SIZE, font=FONT, halign="left", valign="baseline",
                     spacing=LETTER_SPACING);
    }
}

keychain();
