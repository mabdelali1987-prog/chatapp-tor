#!/usr/bin/env bash
set -e
REPO_TMP="/tmp/chatapp-deploy"
APP_DIR="/opt/chatapp"
VENV_DIR="${APP_DIR}/venv"

echo "Stopping existing service (if any)..."
if systemctl is-active --quiet chatapp.service; then
  sudo systemctl stop chatapp.service
fi

echo "Copying files to ${APP_DIR}..."
sudo rm -rf ${APP_DIR}
sudo mkdir -p ${APP_DIR}
sudo cp -r ${REPO_TMP}/* ${APP_DIR}/
sudo chown -R $(whoami):$(whoami) ${APP_DIR}

# Setup Python venv
if [ ! -d "${VENV_DIR}" ]; then
  python3 -m venv ${VENV_DIR}
fi
${VENV_DIR}/bin/pip install --upgrade pip
${VENV_DIR}/bin/pip install -r ${APP_DIR}/requirements.txt

echo "Restarting app..."
sudo systemctl restart chatapp.service || echo "No service yet — skipping"

echo "Deploy done."
