# 🍟 neko_restaurants
Sistema de restaurante para servidores de FiveM basado en QBCore;

- Sistema de inventario (almacén).
- Puntos para obtener alimentos y bebidas _(opcional pueden ser crafteados)_.
- Sistema de "bandejas" para el mostrador.
- Sistema de "bandejas" para las mesas del mapeado.
- Sistema de menú (con item) para mostrar los articulos en venta en el comercio.
- Sistema de cobro a clientes.
- Sistema de garage.
- Sistema de anuncios abierto/cerrado

---

### Dependencias
- `oxmysql`
- `qb-inventory` o `ox_inventory`
- `ps-ui`
- `qb-radialmenu`
- `qb-input`
- `qb-target`
- `qb-management`
- `qb-banking (old)` o `Renewed-Banking`

---

### Detalles
- Todos los items deben estar registrados en `qb-core/shared/items.lua` (para obtener el nombre) e `ox_inventory/data/items.lua`
- Los items de menú deben tener el nombre de `menu_{nombrefaccion}` (ej: `menu_pizzeria`)
- Los items para craftear la comida o bebida (opcionales, dejar como '' si no se quiere utilizar item), deben ser declarados en el config y ubicar en alguna tienda para adquirirlos (que la economía fluya pls)

---

### Sistema de acciones (qb-radialmenu)
![image](https://github.com/imkuroneko/neko_restaurants/assets/20273059/3d90091c-3878-4df0-acac-8262b4e1951b)

### Sistema de garage
![image](https://github.com/imkuroneko/neko_restaurants/assets/20273059/23f53685-cc3a-4624-bff6-a09384944359)

### Sistema de items/crafteo
![image](https://github.com/imkuroneko/neko_restaurants/assets/20273059/bbe253f4-b343-45ba-bb1c-8cb1f6a94ddf)
![image](https://github.com/imkuroneko/neko_restaurants/assets/20273059/f05123b5-7483-46cf-b69e-3d5526bf43df)

### Stash mostrador
![image](https://github.com/imkuroneko/neko_restaurants/assets/20273059/838ba6a4-9972-43a3-8293-1a4ec3e0ad12)

### Stash inventario
![image](https://github.com/imkuroneko/neko_restaurants/assets/20273059/692b781c-7a4c-4431-affa-77b0a6df2c2d)

### Sistema de cobros
(pendiente de subir la foto 😅)
