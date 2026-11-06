#!/usr/bin/env bash
# Script de verificación de integridad SHA-256 para FC-LAB-004
set -e
echo 'Verificando integridad SHA-256 de archivos extraídos...'
sha256sum ../originales/*.txt *.txt
