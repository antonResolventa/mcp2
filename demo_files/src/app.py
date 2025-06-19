#!/usr/bin/env python3
"""
Пример Python файла для демонстрации MCP filesystem
"""
import os
import json
import datetime


class DataProcessor:
    """Пример класса для обработки данных"""
    
    def __init__(self, data_dir=None):
        self.data_dir = data_dir or "data"
        os.makedirs(self.data_dir, exist_ok=True)
        
    def load_data(self, filename):
        """Загрузка данных из JSON файла"""
        filepath = os.path.join(self.data_dir, filename)
        try:
            with open(filepath, "r", encoding="utf-8") as f:
                return json.load(f)
        except FileNotFoundError:
            print(f"Файл {filepath} не найден")
            return {}
        except json.JSONDecodeError:
            print(f"Ошибка декодирования JSON в файле {filepath}")
            return {}
    
    def save_data(self, data, filename):
        """Сохранение данных в JSON файл"""
        filepath = os.path.join(self.data_dir, filename)
        with open(filepath, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        print(f"Данные сохранены в {filepath}")
    
    def process_data(self, data):
        """Пример обработки данных"""
        if not data:
            return {}
        
        # Добавляем метаданные
        result = {
            "original": data,
            "metadata": {
                "processed_at": datetime.datetime.now().isoformat(),
                "item_count": len(data) if isinstance(data, list) else 1,
                "processor": "DataProcessor v1.0"
            }
        }
        
        return result


def main():
    """Основная функция"""
    processor = DataProcessor()
    
    # Пример данных
    sample_data = [
        {"id": 1, "name": "Иван", "age": 30},
        {"id": 2, "name": "Мария", "age": 25},
        {"id": 3, "name": "Петр", "age": 40}
    ]
    
    # Обработка данных
    processed = processor.process_data(sample_data)
    
    # Сохранение результатов
    processor.save_data(processed, "результаты.json")
    
    print("Обработка завершена!")


if __name__ == "__main__":
    main()
