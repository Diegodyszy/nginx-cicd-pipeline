#!/usr/bin/env bash
set -euo pipefail

URL="${1:-http://localhost:8080}"

echo "[1/3] Validando sintaxe do docker-compose.yml..."
docker compose config -q

echo "[2/3] Validando configuração do Nginx no container..."
docker compose exec -T nginx nginx -t

echo "[3/3] Testando resposta HTTP em ${URL}..."
response=$(curl -fsS --max-time 5 "${URL}")

if [[ -z "${response}" ]]; then
  echo "ERRO: Resposta vazia recebida de ${URL}" >&2
  exit 1
fi

echo "OK: Smoke test passou com sucesso. Resposta: ${response}"
