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

<h3 align="center">Puntos de alimentos y bebidas</h3>
<table>
    <tr> <th> Lista de items </th> <th> Tienda </th> </tr>
    <tr>
        <td> <img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/0d67c495-22d3-4844-af32-705ae667410a" alt="Lista de items"/> </td>
        <td> <img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/0f042b1f-4c39-43ca-bd68-4ce8166a1346" alt="Tienda"/> </td>
    </tr>
</table>

<h3 align="center">Stashes</h3>
<table>
    <tr> <th> Inventario </th> <th> Mostrador </th> </tr>
    <tr>
        <td> <img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/2331b35e-1c74-46f8-ad48-ed9ef0fd4bda" alt="Stash inventario"/> </td>
        <td> <img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/13184a2e-6d5e-47d9-94b2-54264a976274" alt="Stash mostrador"/> </td>
    </tr>
</table>

<h3 align="center">Sistema de cobros</h3>
<table>
    <tr> <th> Vista empleado </th> <th> Vista cliente </th> </tr>
    <tr>
        <td> <img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/035024b2-23d1-4921-8ac6-baeea72d7a4b" alt="Vista empleado"/> </td>
        <td> <img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/035024b2-23d1-4921-8ac6-baeea72d7a4b" alt="Vista cliente"/> </td>
    </tr>
</table>

-----

<p align="center">
  <a href="https://kuroneko.im" target="_blank">
    <img src="https://kuroneko.im/web/assets/images/profile.png" width="120">
  </a>
</p>
