#!/bin/bash

# Ottieni il percorso assoluto della directory dello script
script_dir=$(dirname "$0")

# Trova tutte le sottocartelle nella directory dello script
find "$script_dir" -maxdepth 1 -type d -print0 | while IFS= read -r -d $'\0' cartella; do
  # Estrai il nome della cartella
  nome_cartella=$(basename "$cartella")

  # Verifica se il nome della cartella contiene "_"
  if [[ "$nome_cartella" == *_* ]]; then
    # Sostituisci "_" con "-"
    nuovo_nome_cartella="${nome_cartella//_/}"

    # Questa è la riga corretta:
    nuovo_nome_cartella=$(echo "$nuovo_nome_cartella" | sed 's/ *- */-/g')

    # Costruisci il nuovo percorso completo
    nuovo_percorso_cartella="${cartella%/*}/$nuovo_nome_cartella"

    # Rinomina la cartella (solo se necessario)
    if [[ "$cartella" != "$nuovo_percorso_cartella" ]]; then
        echo "Rinomino: '$cartella' in '$nuovo_percorso_cartella'"
        mv "$cartella" "$nuovo_percorso_cartella"
    else
        echo "nessuna modifica per la cartella: '$cartella'"
    fi
  fi
done

echo "Operazione completata."

exit 0