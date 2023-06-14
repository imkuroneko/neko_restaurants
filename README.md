# 🍟 neko_restaurants [WIP]
Sistema de restaurante para servidores de FiveM basado en QBCore;

- Sistema de inventario
- Puntos para crafteo de alimentos y bebidas (opcional que estos dependan de un item para poder ser crafteados)
- Sistema de "bandejas" para el mostrador
- Sistema de "bandejas" para las mesas del mapeado

---

### Detalles
- Todos los items deben estar ya registrados en `qb-core/shared/items.lua`
- Los items de menú deben tener el nombre de `menu_{nombrefaccion}` (ej: `menu_pizzeria`)
- Para acceder al menú para cambio de imagen del menú, hay que agregar lo siguiente al qb-radialmenu:
```
{ id = 'updateMenu', title = 'Actualizar Menú', icon = 'clipboard', type = 'client', event = 'neko_restaurants:client:updateMenu', shouldClose = true }
```
- Aún no está preparado (proximos updates) para el sistema de garage
- Los items para craftear la comida o bebida (opcionales, dejar como '' si no se quiere utilizar item), deben ser declarados en el config y ubicar en alguna tienda para adquirirlos (que la economía fluya pls)

---

### Dependencias
- qb-inventory
- qb-input
- qb-target
- qb-radialmenu
- oxmysql
