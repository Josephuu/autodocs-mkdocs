#!/bin/bash
set -e
WS="${WORKSPACE:-/workspace}"
DOCS_DIR="${WS}/docs"
echo "Generando indices..."
mkdir -p "${DOCS_DIR}"

for dir in terraform ansible kubernetes docker runbooks; do
    mkdir -p "${DOCS_DIR}/$dir"
    echo "# ${dir}" > "${DOCS_DIR}/${dir}/index.md"
done

echo "OK"
