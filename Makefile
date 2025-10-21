# Makefile для компиляции LaTeX документа с отдельной папкой build

# Основные переменные
MAIN = main
LATEX = pdflatex
BIBTEX = biber
VIEWER = open
BUILD_DIR = build

# Цели по умолчанию
.PHONY: all clean view help

# Компиляция документа в папку build
all: $(BUILD_DIR)/$(MAIN).pdf

$(BUILD_DIR)/$(MAIN).pdf: $(MAIN).tex
	@mkdir -p $(BUILD_DIR)
	$(LATEX) -shell-escape -output-directory=$(BUILD_DIR) $(MAIN).tex
	$(BIBTEX) $(BUILD_DIR)/$(MAIN)
	$(LATEX) -shell-escape -output-directory=$(BUILD_DIR) $(MAIN).tex
	$(LATEX) -shell-escape -output-directory=$(BUILD_DIR) $(MAIN).tex

# Быстрая компиляция (без библиографии)
quick: $(MAIN).tex
	@mkdir -p $(BUILD_DIR)
	$(LATEX) -shell-escape -output-directory=$(BUILD_DIR) $(MAIN).tex

# Просмотр PDF
view: $(BUILD_DIR)/$(MAIN).pdf
	$(VIEWER) $(BUILD_DIR)/$(MAIN).pdf

# Очистка временных файлов (удаляем всю папку build)
clean:
	rm -rf $(BUILD_DIR)

# Полная очистка (включая PDF)
distclean: clean
	rm -f $(MAIN).pdf

# Справка
help:
	@echo "Доступные команды:"
	@echo "  make        - Полная компиляция документа в папку build/"
	@echo "  make quick  - Быстрая компиляция (без библиографии) в папку build/"
	@echo "  make view   - Открыть PDF файл из папки build/"
	@echo "  make clean  - Удалить папку build/ со всеми временными файлами"
	@echo "  make distclean - Удалить все сгенерированные файлы"
	@echo "  make help   - Показать эту справку"