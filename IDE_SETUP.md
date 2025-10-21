# Настройка IDE для работы с LaTeX проектом

## Cursor + LaTeX Workshop

### 1. Установка расширения
- Установите расширение "LaTeX Workshop" в Cursor
- Перезапустите Cursor

### 2. Настройка PATH
Добавьте в ваш `~/.zshrc` или `~/.bash_profile`:
```bash
export PATH="/Library/TeX/texbin:$PATH"
```

Затем выполните:
```bash
source ~/.zshrc
```

### 3. Использование
1. Откройте файл `main.tex` в Cursor
2. Нажмите `Ctrl+Alt+B` (или `Cmd+Option+B` на Mac) для компиляции
3. Или используйте панель команд: `Ctrl+Shift+P` → "LaTeX Workshop: Build LaTeX project"

### 4. Автоматическая компиляция
- Файл автоматически компилируется при сохранении
- PDF откроется в новой вкладке Cursor

## Альтернативные способы компиляции

### Через терминал
```bash
# Полная компиляция
make

# Быстрая компиляция
make quick

# Открыть PDF
make view
```

### Через latexmk
```bash
latexmk -pdf main.tex
```

## Устранение проблем

### Проблема: "Cannot find LaTeX root file"
**Решение**: Убедитесь, что:
1. Файл `main.tex` открыт в Cursor
2. Расширение LaTeX Workshop установлено
3. PATH настроен правильно
4. В настройках указан корневой файл: `main.tex`

### Проблема: "pdflatex not found"
**Решение**: 
1. Установите MacTeX: `brew install --cask mactex`
2. Добавьте PATH в профиль оболочки
3. Перезапустите терминал и Cursor

### Проблема: Ошибки компиляции
**Решение**:
1. Проверьте синтаксис LaTeX
2. Убедитесь, что все пакеты установлены
3. Используйте `make clean` для очистки временных файлов
