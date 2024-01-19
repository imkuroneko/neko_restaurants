# 🍟 neko_restaurants
Sistema de restaurante para servidores de FiveM basado en QBCore;

- Sistema de inventario
- Puntos para crafteo de alimentos y bebidas _(opcional que estos dependan de un item para poder ser crafteados)_
- Sistema de "bandejas" para el mostrador
- Sistema de "bandejas" para las mesas del mapeado
- Sistema de menú (con item) para mostrar los articulos en venta en el comercio

---

### Dependencias
- **bd:** `oxmysql`
- **inventario:** `qb-inventory` o `ox_inventory`
- **sistema de menú/carta:** `ps-ui`, `qb-radialmenu` y `qb-input`
- **interacción con los puntos:** `qb-target`

---

### Detalles
- Todos los items deben estar ya registrados en `qb-core/shared/items.lua` o `ox_inventory/data/items.lua`
- Los items de menú deben tener el nombre de `menu_{nombrefaccion}` (ej: `menu_pizzeria`)
- Para acceder al menú para cambio de imagen del menú, hay que agregar lo siguiente al qb-radialmenu:
```
{ id = 'updateMenu', title = 'Actualizar Menú', icon = 'clipboard', type = 'client', event = 'neko_restaurants:client:updateMenu', shouldClose = true }
```
- Los items para craftear la comida o bebida (opcionales, dejar como '' si no se quiere utilizar item), deben ser declarados en el config y ubicar en alguna tienda para adquirirlos (que la economía fluya pls)

---

### Proximamente
- Sistema de "garage" para las facciones (punto de spawn/guardado y menú de selección de vehículo temporal)

---

#### Agradecimientos:
a [@imcastee](https://github.com/imcastee) por ayudarme en la lógica de algunas cosas y la paciencia para cuando no funcionaba algo XD
