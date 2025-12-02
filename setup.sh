#!/bin/bash
# Скрипт для быстрой инициализации проекта LaTeX диссертации
# Использование: ./setup.sh

set -e

echo "=========================================="
echo "Инициализация проекта LaTeX диссертации"
echo "=========================================="
echo ""

# Проверка наличия необходимых инструментов
echo "Проверка необходимых инструментов..."
command -v pdflatex >/dev/null 2>&1 || { echo "Ошибка: pdflatex не найден. Установите TeX Live или MiKTeX."; exit 1; }
command -v biber >/dev/null 2>&1 || { echo "Ошибка: biber не найден. Установите Biber."; exit 1; }
command -v make >/dev/null 2>&1 || { echo "Предупреждение: make не найден. Команда 'make' может не работать."; }
echo "✓ Все необходимые инструменты найдены"
echo ""

# Создание структуры папок, если их нет
echo "Создание структуры папок..."
mkdir -p src/chapters
mkdir -p src/images
mkdir -p src/appendix
mkdir -p bibliography
mkdir -p config
mkdir -p title
mkdir -p executors
mkdir -p abstract
mkdir -p terms
mkdir -p abbreviations
mkdir -p appendix
echo "✓ Структура папок создана"
echo ""

# Копирование конфигурации путей, если её нет
if [ ! -f config/paths.tex ]; then
    echo "Создание конфигурации путей..."
    cp config/paths.example.tex config/paths.tex 2>/dev/null || {
        echo "Создание базовой конфигурации путей..."
        cat > config/paths.tex << 'EOF'
% Конфигурация путей к источникам
\newcommand{\chapterspath}{src/chapters}
\newcommand{\imagespath}{src/images}
\newcommand{\appendixpath}{src/appendix}
\newcommand{\bibliographypath}{bibliography}

% Команды для удобного подключения файлов
\newcommand{\inputchapter}[1]{\input{\chapterspath/#1}}
\newcommand{\inputappendix}[1]{\input{\appendixpath/#1}}

% Команда для включения изображений
\newcommand{\includegraphicspath}[2][]{%
  \ifx\relax#1\relax
    \includegraphics{\imagespath/#2}%
  \else
    \includegraphics[#1]{\imagespath/#2}%
  \fi
}
EOF
    }
    echo "✓ Конфигурация путей создана"
else
    echo "✓ Конфигурация путей уже существует"
fi
echo ""

# Проверка наличия основных файлов
echo "Проверка основных файлов..."
if [ ! -f main.tex ]; then
    echo "⚠ Предупреждение: main.tex не найден"
fi
if [ ! -f Makefile ]; then
    echo "⚠ Предупреждение: Makefile не найден"
fi
echo ""

# Информация о следующем шаге
echo "=========================================="
echo "Инициализация завершена!"
echo "=========================================="
echo ""
echo "Следующие шаги:"
echo "1. Поместите ваши главы в папку src/chapters/"
echo "2. Поместите изображения в папку src/images/"
echo "3. Поместите приложения в папку src/appendix/"
echo "4. Добавьте библиографию в bibliography/references.bib"
echo "5. Настройте config/paths.tex при необходимости"
echo ""
echo "Для компиляции документа используйте:"
echo "  make        # Полная компиляция"
echo "  make quick  # Быстрая компиляция (без библиографии)"
echo "  make view   # Открыть PDF"
echo "  make clean  # Очистить временные файлы"
echo ""
echo "PDF будет создан в папке build/main.pdf"
echo ""

