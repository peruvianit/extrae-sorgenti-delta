<#
Script: convert-PathToJavaPackage.ps1
Autore: Peruvianit (sergioarellanodiaz@gmail.com)
Data di creazione: 17/04/2024
Versione: 1.0.0
Descrizione: Legge una diretory e crea una lista dei file in convenzioni package di java
             esempio : c:/Temp/cartella/File.java crea come risultato -> temp.cartella.File se 
             viene configurato $removePrefix = temp. il risultato sarebbe cartella.File.
Informazioni aggiuntive: file powershell perché più del 95% di sviluppatori utilizzano Windows. Questo script stato realizzato
su una macchina con windows 11
#>


#--> Configurazione Script
# Cartella di destinazione per i file estratti e date da impostare

$startingDir = "C:/Temp/sorgenti-git-20240417/GIF2020-GestioneProgramma/src/main/java"
$removePrefix = "^src\.main\.java\."


function Convert-PathToJavaPackage {
    param (
        [string]$Path
    )

    # Process all .java files in the current directory
    Get-ChildItem -Path $Path -Filter *.java -File | ForEach-Object {
        $relativePath = $_.FullName -replace [regex]::Escape((Get-Location).Path + '\'), ''
        $packagePath = $relativePath -replace '\\', '.' -replace '/', '.' -replace '\.java$', ''
        $packagePath = $packagePath -replace $removeprefix, ''  
        Write-Output $packagePath
    }

    # Recursively call this function for each subdirectory
    Get-ChildItem -Path $Path -Directory | ForEach-Object {
        Convert-PathToJavaPackage -Path $_.FullName
    }
}

# Starting directory for the recursion
Convert-PathToJavaPackage -Path $startingDir