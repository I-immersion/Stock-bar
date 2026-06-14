#!/bin/bash
# LUMIIA Stock — déploiement GitHub Pages (double-clic macOS)
# Place ce fichier à la racine du dossier projet (à côté de index.html).

cd "$(dirname "$0")" || exit 1

echo "═══════════════════════════════════════"
echo "  📦  LUMIIA Stock — déploiement"
echo "═══════════════════════════════════════"
echo "Dossier : $(pwd)"
echo

if [ ! -d .git ]; then
  echo "❌  Ce dossier n'est pas un dépôt git (pas de .git)."
  echo "    Initialise-le d'abord, ou place ce script dans le bon dossier."
  echo
  read -n 1 -s -r -p "Appuie sur une touche pour fermer…"
  exit 1
fi

read -r -p "Message de commit (laisse vide = horodatage) : " MSG
if [ -z "$MSG" ]; then MSG="maj $(date '+%Y-%m-%d %H:%M')"; fi

echo
git add -A
git commit -m "$MSG" || echo "ℹ️  Rien de nouveau à committer."
echo
echo "⬆️   Envoi vers GitHub…"
if git push -u origin HEAD; then
  echo
  echo "✅  Déployé. En ligne dans ~1 min :"
  echo "    https://i-immersion.github.io/Stock-bar/"
  echo "    (recharge sans cache / navigation privée pour voir la nouvelle version)"
else
  echo
  echo "❌  Le push a échoué — lis le message ci-dessus."
fi
echo
read -n 1 -s -r -p "Appuie sur une touche pour fermer…"
