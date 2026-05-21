#!/bin/bash
set -euo pipefail

# Скрипт объединения frontmatter PDF + основного PDF диссертации
# Использует pdfunite (из poppler-utils)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="${ROOT_DIR}/build"
FRONTMATTER_DIR="${ROOT_DIR}/assets/frontmatter"

# Проверка зависимостей
if ! command -v pdfunite &> /dev/null; then
    echo "❌ Ошибка: pdfunite не найден. Установите poppler-utils:"
    echo "   macOS: brew install poppler"
    echo "   Ubuntu: sudo apt-get install poppler-utils"
    exit 1
fi

# Проверка наличия основного PDF
if [ ! -f "${BUILD_DIR}/main.pdf" ]; then
    echo "❌ Ошибка: ${BUILD_DIR}/main.pdf не найден. Соберите PDF сначала: make pdf"
    exit 1
fi

# Определяем порядок frontmatter файлов
FRONTMATTER_FILES=(
    "${FRONTMATTER_DIR}/01_title.pdf"
    "${FRONTMATTER_DIR}/02_task.pdf"
    "${FRONTMATTER_DIR}/03_annotation_ru.pdf"
    "${FRONTMATTER_DIR}/04_annotation_en.pdf"
)

# Проверяем наличие каждого frontmatter файла
MISSING=0
for f in "${FRONTMATTER_FILES[@]}"; do
    if [ ! -f "$f" ]; then
        echo "⚠ Предупреждение: $(basename "$f") не найден, пропускаем"
        MISSING=1
    fi
done

# Формируем список существующих файлов
MERGE_FILES=()
for f in "${FRONTMATTER_FILES[@]}"; do
    if [ -f "$f" ]; then
        MERGE_FILES+=("$f")
    fi
done

# Добавляем основной PDF
MERGE_FILES+=("${BUILD_DIR}/main.pdf")

# Результирующий файл
OUTPUT="${BUILD_DIR}/final.pdf"

echo "=== Объединение PDF ==="
echo "Frontmatter файлы:"
for f in "${FRONTMATTER_FILES[@]}"; do
    if [ -f "$f" ]; then
        PAGES=$(pdfinfo "$f" 2>/dev/null | grep "Pages:" | awk '{print $2}' || echo "?")
        echo "  ✓ $(basename "$f") — ${PAGES} стр."
    else
        echo "  ✗ $(basename "$f") — отсутствует"
    fi
done

echo ""
echo "Основной документ: build/main.pdf"
PAGES=$(pdfinfo "${BUILD_DIR}/main.pdf" 2>/dev/null | grep "Pages:" | awk '{print $2}' || echo "?")
echo "  ✓ main.pdf — ${PAGES} стр."

echo ""
echo "Объединение в ${OUTPUT}..."
pdfunite "${MERGE_FILES[@]}" "$OUTPUT"

echo ""
echo "✓ Готово! Итоговый PDF: ${OUTPUT}"
TOTAL_PAGES=$(pdfinfo "$OUTPUT" 2>/dev/null | grep "Pages:" | awk '{print $2}' || echo "?")
echo "  Общее количество страниц: ${TOTAL_PAGES}"
ls -lh "$OUTPUT" | awk '{print "  Размер: " $5}'
