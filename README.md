<h1 align="center">🍟 neko_restaurants</h1>

<p align="center">
  <img src="https://img.shields.io/github/repo-size/imkuroneko/neko_restaurants?style=flat"/> &nbsp;
  <img src="https://img.shields.io/github/languages/top/imkuroneko/neko_restaurants?style=flat"/> &nbsp;
  <img src="https://img.shields.io/github/last-commit/imkuroneko/neko_restaurants?color=pink&style=flat"/>
</p>


Sistema de restaurante para servidores de FiveM basado en QBCore;

- Sistema de inventario (almacén).
- Puntos para obtener alimentos y bebidas _(opcional pueden ser crafteados)_.
- Sistema de "bandejas" para el mostrador.
- Sistema de "bandejas" para las mesas del mapeado.
- Sistema de menú (con item) para mostrar los articulos en venta en el comercio.
- Sistema de cobro a clientes.
- Sistema de garage.
- Sistema de anuncios abierto/cerrado. _(basado en `Manu-JobNotifications`)_

<br>

### 📦 Dependencias
- `oxmysql`
- `ox_lib`
- `ox_inventory`
- `ps-ui`
- `qb-radialmenu`
- `qb-input`
- `qb-target`
- `qb-management`
- `qb-banking (old)` o `Renewed-Banking`
- `qb-phone` o `qs-smartphone`
- `illenium-apearance`

<br>

### 🦄 Detalles
- Todos los items deben estar registrados en `ox_inventory/data/items.lua` (de usar este inventario)
- Los items de menú deben tener el nombre de `menu_{nombrefaccion}` (ej: `menu_pizzeria`)
- Los items para craftear la comida o bebida (se pueden setear como `''` o `false` si no se utilizará)

<br>

### 📋 WIP
- [ ] Cambiar funcionalidad de facturación

<br>

> [!NOTE]
> La mayor parte del proyecto ahora se encuentra funcionando gracias a **ox_lib** y **ox_inventory**; El soporte para otros sistemas de inventario se han removido y se estará trabajando para llegar al mayor porcentaje de uso de las funciones de **ox_lib** para su facil migración a otros frameworks

<br>

<h3 align="center">Sistema de acciones (qb-radialmenu)</h3>
<p align="center"><img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/781bf0cc-5e54-4688-8ddf-41f991d1bf2e"/></p>

<h3 align="center">Sistema de garage</h3>
<p align="center"><img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/23f53685-cc3a-4624-bff6-a09384944359"/></p>

<h3 align="center">Sistema de items/crafteo (disponible para usar menú o tienda)</h3>
<p align="center"><img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/c54f8639-9df3-431e-8b9a-8d85e1c26af6"/></p>
<p align="center"><img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/06fa0b74-d53d-4968-bfd2-14b20b35603b"/></p>

<h3 align="center">Stash mostrador</h3>
<p align="center"><img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/838ba6a4-9972-43a3-8293-1a4ec3e0ad12"/></p>

<h3 align="center">Stash inventario</h3>
<p align="center"><img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/692b781c-7a4c-4431-affa-77b0a6df2c2d"/></p>

<h3 align="center">Sistema de cobros</h3>
<p align="center">(pendiente de subir la captura 😅)</p>

-----

<p align="center">
  <a href="https://kuroneko.im" target="_blank">
    <img src="https://kuroneko.im/web/assets/images/profile.png" width="120">
  </a>
</p>
