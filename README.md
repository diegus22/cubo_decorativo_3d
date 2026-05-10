# Diseños 3D imprimibles — Diego García

Repo único con varios objetos 3D paramétricos generados con OpenSCAD.

## Contenido

| Archivo | Qué es |
|---|---|
| `cubo_decorativo.scad` | Cubo decorativo original |
| `llavero.scad` | **Llavero personalizable** con texto + aro (manifold) |
| `render.sh` | Render batch desde CLI |
| `stl/` | STLs renderizados listos para imprimir |

## Quickstart

```bash
brew install --cask openscad
./render.sh LORETO DIEGO AVIOT
ls stl/
```

## Llavero parametrizable

Edita parámetros al principio de `llavero.scad` (texto, fuente, tamaño,
diámetro del aro, etc.) o pasa la palabra como argumento al render:

```bash
./render.sh "MARIA"   # → stl/MARIA.stl
```

Características:
- ✅ Manifold (un solo cuerpo, sin huecos parásitos) — verificado con CGAL
- ✅ Imprime sin soportes (cara plana abajo)
- ✅ Aro integrado, diámetro ajustable
- ✅ Material: PLA / PETG / ABS

## Tips de impresión

- Capa: 0.16 mm (FDM), 0.05 mm (SLA)
- Relleno: 20% (poca tensión mecánica)
- Sin soportes con la cara plana abajo
- Lija ligeramente el aro con papel 400 si quedan bavas
