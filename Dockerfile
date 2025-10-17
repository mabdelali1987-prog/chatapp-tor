# Utilise Python 3.11 comme base
FROM python:3.11-slim

# Crée un dossier de travail
WORKDIR /app

# Copie les fichiers du projet
COPY . /app

# Installe les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Expose le port interne
EXPOSE 8080

# Lance l'application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
