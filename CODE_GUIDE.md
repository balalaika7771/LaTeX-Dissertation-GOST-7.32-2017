# 🎯 УЛЬТИМАТИВНЫЙ СПОСОБ ОПИСАНИЯ КОДА

## 📋 Единственный стиль для всех языков программирования

### ✨ Использование

```latex
\begin{lstlisting}[style=code, language=ЯЗЫК, caption={Описание}, label={lst:метка}]
ваш код здесь
\end{lstlisting}
```

### 🔧 Параметры

- `style=code` - ультимативный стиль с подсветкой синтаксиса
- `language=Python|Java|C++|JavaScript|...` - язык программирования
- `caption={Описание}` - подпись к листингу
- `label={lst:метка}` - метка для ссылок

### 📝 Примеры

#### Python код
```latex
\begin{lstlisting}[style=code, language=Python, caption={Пример Python функции}, label={lst:python_func}]
def calculate_sum(a, b):
    """Calculate sum of two numbers"""
    return a + b

result = calculate_sum(5, 3)
print(f"Sum: {result}")
\end{lstlisting}
```

#### Java код
```latex
\begin{lstlisting}[style=code, language=Java, caption={Пример Java класса}, label={lst:java_class}]
public class Calculator {
    private double result;
    
    public double add(double a, double b) {
        result = a + b;
        return result;
    }
}
\end{lstlisting}
```

#### C++ код
```latex
\begin{lstlisting}[style=code, language=C++, caption={Пример C++ класса}, label={lst:cpp_class}]
#include <iostream>

class Matrix {
private:
    int rows, cols;
    
public:
    Matrix(int r, int c) : rows(r), cols(c) {}
};
\end{lstlisting}
```

### 🎨 Особенности стиля `code`

- ✅ **Автоматический перенос строк** - длинные строки переносятся автоматически
- ✅ **Подсветка синтаксиса** - ключевые слова, комментарии, строки выделены цветом
- ✅ **Нумерация строк** - автоматическая нумерация слева
- ✅ **Рамка** - красивая рамка вокруг кода
- ✅ **Поддержка UTF-8** - корректное отображение русских символов
- ✅ **Совместимость с ГОСТ** - соответствует требованиям ГОСТ 7.32-2017

### 🔗 Ссылки на листинги

```latex
См. \ref{lst:python_func} для примера Python кода.
```

### 📚 Поддерживаемые языки

- Python
- Java
- C++
- JavaScript
- C
- C#
- PHP
- Ruby
- Go
- Rust
- И многие другие!

### 💡 Совет

Используйте **только** этот способ для всех листингов кода в диссертации. Это обеспечит единообразное оформление и соответствие ГОСТ.
