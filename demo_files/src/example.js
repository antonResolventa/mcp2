/**
 * Пример JavaScript файла для демонстрации MCP filesystem
 */
function greet(name) {
  return `Привет, ${name}!`;
}

// Пример объекта с данными
const user = {
  id: 1,
  name: "Иван Иванов",
  email: "ivan@example.com",
  roles: ["admin", "developer"],
  settings: {
    theme: "dark",
    notifications: true,
    language: "ru"
  }
};

// Пример обработки ошибок
function fetchData(url) {
  return fetch(url)
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      return response.json();
    })
    .catch(error => {
      console.error("Ошибка при загрузке данных:", error);
    });
}

// Пример асинхронной функции
async function processUserData(userId) {
  try {
    const userData = await fetchData(`/api/users/${userId}`);
    console.log("Данные пользователя:", userData);
    return userData;
  } catch (error) {
    console.error("Не удалось обработать данные пользователя:", error);
    return null;
  }
}

// Экспорт функций для использования в других модулях
module.exports = {
  greet,
  user,
  fetchData,
  processUserData
};
