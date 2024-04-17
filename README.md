# extrae-sorgenti-delta 1.0.0
> Script per : Windows PowerShell

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://#)

### Info

Script <strong>per la extrazione del file elaborati tra due date dei sorgenti</strong>, utilizzo per la consegnare al cliente del Delta del codice modificato tra un reladcio ed un'altro.

### Utilizzo
Copiare il file extrae_sorgente-git.ps1 dentro della cartella dove se trova i puntamenti al reposirory git <strong>(cartella .git)</strong></br>

### Configurazione
Modificare sul file shell la sezione :
> <strong>destination_folder:</strong> Dove vengono copiati i file extrati</br>
> <strong>start_date :</strong> Da che data se inizia l'estrazione</br>
> <strong>end_date :</strong> Fino a che data se finisce l'estrazione, se la data è vuota viene calcolata la data odierna

```bash
#--> Configurazione Script
# Cartella di destinazione per i file estratti e date da impostare

$destination_folder = "C:\Temp\sorgenti-git\"
$start_date = "2023-10-03"
$end_date = ""

#--> Fine Configurazione Script

```

### Esecuzione

```bash
.\extrae_sorgente-git.ps1
```

Aprire la cartella destinazione e trovarai la struttura delle cartella ed il sorgente che sono stati modificate tra le due date.

### Creazione lista Files in formato package name convention

Stato aggiunto un script convert-PathToJavaPackage.ps1 per leggere i sorgenti e creare una lista con il formato package di java
