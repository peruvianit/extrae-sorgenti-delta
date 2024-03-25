$OutputEncoding = [System.Text.Encoding]::UTF8

<#
Script: extrae-sorgente-git.ps1
Autore: Peruvianit (sergioarellanodiaz@gmail.com)
Data di creazione: 25/03/2024
Versione: 1.0.0
Descrizione: Legge il log dei commit su Git e dalla lista dei file, vengono copiati su una cartella destinazione. Lo script deve essere copiato sulla cartella dove se trova
             la cartella del repository .git/
Informazioni aggiuntive: file powershell perché più del 95% di sviluppatori utilizzano Windows. Questo script stato realizzato
su una macchina con windows 11
#>

# Imposta la data odierna
$current_date = Get-Date -Format "yyyy-MM-dd"

#--> Configurazione Script
# Cartella di destinazione per i file estratti e date da impostare

$destination_folder = "C:\Temp\sorgenti-git\"
$start_date = "2023-10-03"
$end_date = ""

#--> Fine Configurazione Script


#--> Validazione Date

# Prova a convertire la data in un oggetto di tipo DateTime
try {
    $start_date_as_date = Get-Date $start_date -ErrorAction Stop    
} catch {
    Write-Host "La data iniziale $start_date non valida. Script interrotto."
    exit
}

# Controlla se la variabile $end_date è vuota
if ($end_date -eq "") {
    $end_date = $current_date
}

# Controlla se la variabile $end_date è vuota
if ($end_date -ne "") {    

    # Prova a convertire la data in un oggetto di tipo DateTime
    try {
        $end_date_as_date = Get-Date $end_date -ErrorAction Stop    
    } catch {
        Write-Host "La data finale $end_date non valida. Script interrotto."
        exit
    }
}
#--> Fine Validazione Date

# Ottieni una lista dei commit tra le date specificate
$commits = git log --format="%h" --after="$start_date" --before="$end_date"

# Per ogni commit, estrai i file modificati nella cartella di destinazione
foreach ($commit in $commits) {
    # Ottieni i file modificati in questo commit
    $files = git diff-tree --no-commit-id --name-only -r $commit

    # Copia i file nella cartella di destinazione
    foreach ($file in $files) {
        $destination_path = Join-Path -Path $destination_folder -ChildPath $file
        New-Item -ItemType Directory -Force -Path (Split-Path -Path $destination_path)
        Copy-Item -Path $file -Destination $destination_path -Force
    }
}

Write-Host "File estratti nella cartella di destinazione: $destination_folder"
