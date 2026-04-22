# Instalar skills con Claude Code en Docker

**Para quién** · cualquiera que corre Claude Code adentro de un contenedor (stack `claude-code-docker` · o cualquier setup con `docker run --rm`)
**Cuánto tarda** · 5 min
**Qué vas a lograr** · las 10 skills del kit visibles desde el contenedor · persistentes entre instancias

---

## Por qué no alcanza con `install-kit.sh`

`install-kit.sh` asume que corrés Claude Code directo en tu compu. Hace dos cosas:

1. Clona el repo en `$HOME/.way-of-work-kit/`
2. Crea symlinks en `$HOME/.claude/skills/` apuntando a ese clone

En un setup Docker con `--rm`, la carpeta `~/.claude/` suele estar **montada** desde el host (persiste), pero `$HOME/.way-of-work-kit/` queda adentro del contenedor efímero. Resultado: al cerrar el contenedor, los symlinks quedan colgando apuntando a nada.

---

## La solución · clonar al volumen montado · symlinks relativos

Cloná el repo **dentro** de la carpeta que el contenedor monta como `~/.claude` y usá symlinks relativos. Así todo el árbol vive adentro de un solo volumen persistente · los symlinks resuelven igual en el host y dentro del contenedor.

---

## Paso 1 · Identificá tu mount

Abrí tu `run.sh` (o `docker run`) y buscá la línea que monta `~/.claude`. Ejemplo del stack `claude-code-docker`:

```bash
docker run ... \
    -v "$SCRIPT_DIR/claude-config":/home/claude/.claude \
    ...
```

Acá:
- **Host** · `/Users/<vos>/claude-code-docker/claude-config/`
- **Contenedor** · `/home/claude/.claude/`

Vas a correr todo **desde el host** sobre la carpeta montada.

---

## Paso 2 · Instalá desde el host (5 min)

Desde tu Mac (ajustá la primera `cd` a la ruta real de tu `claude-config`):

```bash
cd /Users/<vos>/claude-code-docker/claude-config
mkdir -p skills way-of-work-kit
cd way-of-work-kit
git clone https://github.com/juan-estrada-itti/way-of-work-tools.git
git clone --depth 1 https://github.com/garrytan/gstack.git
cd ../skills
for s in rfc-to-adr story-to-plan sdd-router taller-participante facilitar-taller \
         lessons-harvester create-prd rfc-builder contract-define \
         user-story-builder task-dependency-analyzer code-review; do
  ln -sfn "../way-of-work-kit/way-of-work-tools/skills/$s" "$s"
done
ln -sfn ../way-of-work-kit/gstack/office-hours office-hours
ls -la
```

Deberías ver 13 symlinks (las 10 principales + 3 extras: `taller-participante`, `facilitar-taller`, `lessons-harvester`).

---

## Paso 3 · Relanzá Claude Code

Las skills se cargan al arrancar · una sesión ya abierta no las va a ver. Salí con `/exit` y relanzá:

```bash
./launch-claude.sh
```

Adentro, apretá `/` · tenés que ver `/create-prd`, `/rfc-builder`, `/office-hours` y las demás.

---

## Por qué funciona · symlinks relativos

El symlink es un string con una ruta relativa a donde vive.

| Dónde | Symlink | Resuelve a |
|---|---|---|
| Host | `claude-config/skills/create-prd` | `claude-config/way-of-work-kit/.../create-prd` ✓ |
| Contenedor | `/home/claude/.claude/skills/create-prd` | `/home/claude/.claude/way-of-work-kit/.../create-prd` ✓ |

Es el mismo archivo vía el mount. Con symlinks **absolutos** (`/Users/...`) se rompería adentro del contenedor · por eso siempre relativos.

---

## Actualizar las skills

Cada tanto corré desde el host:

```bash
cd /Users/<vos>/claude-code-docker/claude-config/way-of-work-kit/way-of-work-tools && git pull
cd ../gstack && git pull
```

Los symlinks no cambian · apuntan al mismo árbol.

---

## Alternativa · correr `install-kit.sh` adentro del contenedor

Funciona si modificás el script para que clone a un path montado (ej: `/home/claude/.claude/way-of-work-kit/` en vez de `$HOME/.way-of-work-kit/`). Desaconsejado · más complejo y el clone se re-hace en cada contenedor nuevo. El método de arriba se corre 1 sola vez.

---

## Troubleshooting

| Síntoma | Solución |
|---|---|
| Las skills no aparecen con `/` | Salí y relanzá el contenedor · la sesión vieja no las ve |
| Symlinks rotos adentro del contenedor | Verificá que sean relativos · no absolutos (`ls -la skills/`) |
| `git clone` falla por SSH | Los repos del kit son públicos · usá HTTPS como está en el ejemplo |
| `~/.claude` no está montado | Editá tu `run.sh` para agregar `-v /host/claude-config:/home/claude/.claude` |
| Skills duplicadas (nombre-X · nombre-X 2) | Borraste symlinks y el FS los recreó · limpiá `skills/` y corré Paso 2 otra vez |

---

**Última actualización** · 2026-04-22
