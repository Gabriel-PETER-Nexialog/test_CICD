@echo off
SET ENV_NAME=test_CICD_env
SET REQUIREMENTS_FILE=requirements.txt
SET ENV_FILE=environnement.yml

echo ----------------------------------------
echo [1] Verify if conda env existe ...
REM lance la commande conda pour lister les environnements
CALL conda env list | FINDSTR /C:"%ENV_NAME%" >nul

REM regarde si l'environnement existe, Si il existe le deactive et le détruit sinon on fait rien
IF %ERRORLEVEL% ==0 (
    echo [2] L'environnement "%ENV_NAME%" existe. Suppression...
    CALL conda deactivate
    CALL conda env remove -n %ENV_NAME% -y
) ELSE (
    echo [2] L'environnement "%ENV_NAME%" n'existe pas encore.
)

REM Créé l'environnement
echo [3] Creation d'un nouvel environnement "%ENV_NAME%"...
CALL conda create -n %ENV_NAME% python=3.12 -y

REM Active l'environnement
echo [4] Activation env "%ENV_NAME%"...
CALL conda activate %ENV_NAME%

REM Installe les dépendances
echo [5] Installation des Dependance
CALL pip install -r requirements.txt


cmd /k
