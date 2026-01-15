
# ChallengeProductsApp

Aplicación iOS desarrollada como parte de un desafío técnico para un rol Mobile Full-Stack Swift.

El objetivo del proyecto es demostrar buenas prácticas de arquitectura, persistencia local con Core Data, manejo offline-first, uso de SwiftUI, concurrencia moderna con async/await y código testeable.

---

## Funcionalidades

### Lista de Productos
- Obtención de productos desde la API:
  https://fakestoreapi.com/products or se puede usar la api que se genero en https://github.com/JohnnMancilla/challenge-products-api y se puede correr local en http://localhost:3000/products
- Visualización de:
  - Imagen del producto
  - Título
  - Categoría
  - Precio
  - Rating y cantidad de evaluaciones
- Manejo de estados:
  - Loading
  - Error
- Soporte offline-first:
  - Los productos se cargan desde cache local (Core Data)
  - Si existe conexión, los datos se sincronizan en segundo plano
  - Indicador visual muestra si los datos están CACHED o SYNCHRONIZED

---

### Detalle de Producto
- Navegación desde la lista de productos
- Visualización de:
  - Imagen principal (hero)
  - Título
  - Descripción
  - Categoría
  - Precio
  - Rating
- Opción para marcar / desmarcar como favorito

---

### Favoritos
- El usuario puede marcar productos como favoritos
- El estado isFavorite se persiste en Core Data
- Los favoritos se mantienen entre reinicios de la aplicación
- Pantalla dedicada de Favoritos accesible desde el Tab Bar

---

## Arquitectura

La aplicación utiliza una arquitectura MVVM + Repository, separando claramente responsabilidades y facilitando el mantenimiento y testing.

### Capas

Presentation (SwiftUI)  
ViewModels (estado y lógica de presentación)  
Domain (modelos y contratos)  
Data  
- Remote (API, DTOs)  
- Local (Core Data)  
- Repository (orquestación offline-first)  

Core  
- Persistencia (Core Data)

### Principios clave
- Las Views no contienen lógica de negocio
- Los ViewModels exponen estados claros hacia la UI
- El Repository abstrae el origen de los datos
- Core Data actúa como fuente de verdad local
- Navegación desacoplada y basada en estado

---

## Persistencia y Soporte Offline

- Core Data se utiliza como mecanismo de persistencia local
- Los productos se almacenan en la entidad ProductEntity
- El flag isFavorite se guarda directamente en Core Data
- Flujo offline-first:
  - La app muestra inmediatamente los datos en cache
  - La sincronización remota se ejecuta en segundo plano
  - La aplicación funciona sin conexión tras la primera sincronización exitosa

---

## Concurrencia

- Uso de Swift async/await
- Networking implementado con URLSession
- Las actualizaciones de UI se ejecutan en el Main Actor
- La sincronización remota no bloquea la interfaz

---

## Interfaz de Usuario

- Implementada completamente con SwiftUI
- Diseño alineado a una UI de catálogo de productos

- Aplicación iOS-only

---

## Testing

El proyecto incluye tests unitarios utilizando XCTest.

### Cobertura
- Persistencia con Core Data usando store in-memory
- Lógica del Repository (offline-first)
- Transiciones de estado en ViewModels (loading, success, error)

### Enfoque
- Tests unitarios
- No se incluyen UI tests (fuera del alcance del desafío)
- Uso de mocks para aislar dependencias

---

## Tecnologías

- Swift
- SwiftUI
- Core Data
- async/await
- URLSession
- XCTest

No se utilizaron dependencias externas.


---

## Posibles Mejoras

En un entorno productivo se podrían agregar:
- Paginación
- Pull to refresh
- Manejo de reintentos ante error
- Accesibilidad (VoiceOver / Dynamic Type)
- UI tests
- Contextos de escritura en background para Core Data

---

## 👤 Autor: Johnn Mancilla

Desarrollado como entrega de desafío técnico utilizando prácticas modernas de desarrollo iOS.
