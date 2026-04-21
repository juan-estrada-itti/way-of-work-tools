# FAQ · Troubleshooting del kit

Los 8 problemas más probables al instalar · con solución copy-paste.

Si tu problema no está acá · Slack `#way-of-work` · respondo rápido.

---

## 1 · `claude: command not found`

Claude Code no está en el PATH · o no se instaló.

**Fix**
```bash
# Cerrá la terminal y abrí una nueva (a veces alcanza)
# Si persiste, verificá dónde está instalado:
which claude
npm list -g @anthropic-ai/claude-code

# Si no aparece · reinstalá:
npm install -g @anthropic-ai/claude-code

# Si da error de permisos:
sudo npm install -g @anthropic-ai/claude-code

# Verificá PATH · agregar si falta:
echo "export PATH=\"\$(npm config get prefix)/bin:\$PATH\"" >> ~/.zshrc
source ~/.zshrc
```

---

## 2 · Skills no aparecen cuando aprieto `/`

Claude Code cachea las skills al arrancar · los symlinks nuevos no aparecen en una sesión abierta.

**Fix**
```bash
# Cerrá todas las instancias de Claude Code:
pkill -f 'claude' 2>/dev/null

# Abrí una nueva:
claude
# Probá /  de nuevo
```

---

## 3 · Auth falla · *"unable to authenticate"* o *"API key invalid"*

La API key no está configurada, está mal copiada, o fue revocada.

**Fix 1 · verificar que la variable existe**
```bash
echo $ANTHROPIC_API_KEY
# Debería imprimir algo que empieza con sk-ant-api03-...
# Si imprime vacío · la variable no está cargada
```

**Fix 2 · recargar la shell**
```bash
source ~/.zshrc   # macOS/Linux con zsh
# o
source ~/.bashrc  # Linux con bash

# O simplemente cerrá y abrí terminal nueva
```

**Fix 3 · generar una key nueva**
1. Abrí `https://platform.claude.com/settings/workspaces/default/keys`
2. Login con `@itti.digital` (Google SSO)
3. `+ Create key` · nombrala `{tu-nombre}-itti` siguiendo la convención
4. Copiala completa (formato `sk-ant-api03-...`)
5. Pegala al final del archivo:
   ```bash
   # Abrí el archivo:
   nano ~/.zshrc
   # Pegá al final (reemplazando si ya había una vieja):
   export ANTHROPIC_API_KEY="sk-ant-api03-TU-KEY-NUEVA"
   # Guardá con Ctrl+O · Enter · Ctrl+X
   source ~/.zshrc
   ```

**Fix 4 · si no podés acceder a platform.claude.com**
Mandale DM a Juan · revisa que tu email `@itti.digital` esté agregado al workspace.

---

## 4 · `git clone` falla por SSH (`Permission denied (publickey)`)

Tu clave SSH no está agregada a GitHub, o no está cargada en el agent.

**Fix rápido · forzar HTTPS**
```bash
# Configurar git para usar HTTPS siempre que intente SSH:
git config --global url."https://github.com/".insteadOf git@github.com:

# Después correr de nuevo:
bash ~/.way-of-work-kit/way-of-work-tools/kit/install-kit.sh
```

**Fix completo · agregar SSH key**
```bash
# Generá tu SSH key si no tenés:
ssh-keygen -t ed25519 -C "tu-email@itti.digital"

# Copiala:
pbcopy < ~/.ssh/id_ed25519.pub   # macOS
cat ~/.ssh/id_ed25519.pub         # Linux (copia manual)

# Pegala en https://github.com/settings/ssh/new
# Testeala:
ssh -T git@github.com
```

---

## 5 · Corporativo bloquea GitHub / npm / Anthropic

El proxy Netskope o Zscaler interfiere con las descargas.

**Fix rápido** · usá tus datos móviles para la instalación inicial · 30-40 min.

**Fix completo con proxy corporativo**
Pedile a Javier Durán el script `setup-claude-docker.sh` que maneja certificados Netskope · corre todo dentro de un contenedor.

---

## 6 · `worktree add` falla en `install-kit.sh`

Alguna branch ya tiene worktree creado · o el repo está en un estado raro.

**Fix**
```bash
# Borrar el workspace y volver a clonar limpio:
rm -rf ~/.way-of-work-kit
bash <(curl -fsSL https://raw.githubusercontent.com/juan-estrada-itti/way-of-work-tools/main/kit/install-kit.sh)
```

---

## 7 · `/office-hours` no aparece aunque las otras skills sí

Es la única skill externa · viene del repo `garrytan/gstack`. Si el clone de ese repo falló, esa sola falta.

**Fix**
```bash
# Clonar manual:
git clone --depth 1 https://github.com/garrytan/gstack.git ~/.way-of-work-kit/gstack

# Linkear:
ln -sfn ~/.way-of-work-kit/gstack/office-hours ~/.claude/skills/office-hours

# Reiniciar Claude Code:
pkill -f 'claude'; claude
```

---

## 8 · Windows · no tengo WSL y no quiero instalarlo

**Plan B 1** · Cursor (si ya lo tenés)
- Las skills se usan como Rules · en `.cursor/rules/`
- Pedime el paquete convertido · te lo mando

**Plan B 2** · GitHub Copilot
- No tiene skills como tal · pero sí `copilot-instructions.md`
- Te paso el pack con los prompts equivalentes

**Plan B 3** · trabajar con pareja
- En el taller del viernes todo es por pareja
- Aunque no tengas ambiente, podés participar 100%

---

## Cuando todo falla · escape hatches

### Escape 1 · Borrar y reinstalar
```bash
rm -rf ~/.way-of-work-kit
rm -f ~/.claude/skills/office-hours
rm -f ~/.claude/skills/create-prd
rm -f ~/.claude/skills/rfc-builder
rm -f ~/.claude/skills/rfc-to-adr
rm -f ~/.claude/skills/story-to-plan
rm -f ~/.claude/skills/contract-define
rm -f ~/.claude/skills/user-story-builder
rm -f ~/.claude/skills/task-dependency-analyzer
rm -f ~/.claude/skills/code-review
rm -f ~/.claude/skills/sdd-router

bash <(curl -fsSL https://raw.githubusercontent.com/juan-estrada-itti/way-of-work-tools/main/kit/install-kit.sh)
```

### Escape 2 · 1-on-1 con Juan
Reservá 20 min · `calendly.com/juan-estrada-itti/way-of-work-setup`
Instalamos juntos · cero juicio.

### Escape 3 · El viernes trabajás en pareja
Si nada funciona antes del taller · sin drama · venís igual y la pareja que tenga setup comparte pantalla.

---

## Cómo reportar un problema nuevo

1. Ejecutá `verify-kit.sh` · copiás el output
2. En Slack `#way-of-work`:
   ```
   Hola · falla <qué>.
   OS: macOS Sonoma / Ubuntu 22.04 / Windows WSL
   Verify output:
   [pegás]
   ```
3. Agregamos a este FAQ después que lo resolvamos

---

**Última actualización** · 2026-04-21 · Juan Estrada
