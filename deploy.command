#!/bin/bash
# LUMIIA Stock — déploiement GitHub Pages (double-clic macOS) — v2
# v2 : synchro pull --rebase avant push pour éviter les rejets de push

cd "$(dirname "$0")" || exit 1

echo "═══════════════════════════════════════"
echo "  📦  LUMIIA Stock — déploiement v2"
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

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
echo "Branche : $BRANCH"
echo

read -r -p "Message de commit (laisse vide = horodatage) : " MSG
if [ -z "$MSG" ]; then MSG="maj $(date '+%Y-%m-%d %H:%M')"; fi

echo
git add -A
git commit -m "$MSG" || echo "ℹ️  Rien de nouveau à committer."

echo
echo "⬇️   Synchronisation avec GitHub (pull --rebase)…"
if ! git pull --rebase origin "$BRANCH"; then
  echo
  echo "❌  Conflit lors de la synchro. Résous-le à la main"
  echo "    (git status pour voir les fichiers), puis relance ce script."
  echo
  read -n 1 -s -r -p "Appuie sur une touche pour fermer…"
  exit 1
fi

echo
echo "⬆️   Envoi vers GitHub…"
if git push -u origin "$BRANCH"; then
  echo
  echo "✅  Déployé. En ligne dans ~1 min :"
  echo "    https://i-immersion.github.io/Stock-bar/"
  echo "    (Cmd+Shift+R pour recharger sans cache, ou navigation privée)"
else
  echo
  echo "❌  Le push a échoué — lis le message ci-dessus."
fi
echo
read -n 1 -s -r -p "Appuie sur une touche pour fermer…"
