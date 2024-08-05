> [!WARNING]  
> Este proyecto es **100% open source**, por lo que **NO ofrezco soporte para el mismo**. <br>
> This project is **100% open source**, so **I will not provide support for it**

<h1 align="center">🍟 neko_restaurants</h1>

<p align="center">
  <img src="https://img.shields.io/github/repo-size/imkuroneko/neko_restaurants?style=flat"/> &nbsp;
  <img src="https://img.shields.io/github/languages/top/imkuroneko/neko_restaurants?style=flat"/> &nbsp;
  <img src="https://img.shields.io/github/last-commit/imkuroneko/neko_restaurants?color=pink&style=flat"/> &nbsp;
  <img src="https://img.shields.io/github/downloads/imkuroneko/neko_restaurants/total?logo=github"/> &nbsp;
  <img src="https://img.shields.io/github/v/release/imkuroneko/neko_restaurants?logo=github"/> &nbsp;
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
- Todos los textos se encuentran en `locales/es.json` por si desees agregar otros idiomas o modificar algo a tu gusto.

<br>

> [!NOTE]
> - El proyecto utiliza el sistema de traducciones de **ox_lib**, para que funcione deberás agregar en tu archivo `.cfg` lo siguiente: `setr ox:locale es`
> - La mayor parte del proyecto ahora se encuentra funcionando gracias a **ox_lib** y **ox_inventory**; El soporte para otros sistemas de inventario se han removido y se estará trabajando para llegar al mayor porcentaje de uso de las funciones de **ox_lib** para su facil adaptación a otros frameworks

<br>

<h3 align="center">Sistema de acciones (qb-radialmenu)</h3>
<table>
    <tr> <th> Menú principal </th> <th> Sistema de avisos </th> </tr>
    <tr>
        <td> <img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/e5c5be3f-6d15-439f-82e3-b2f9eca474f8" alt="Menú principal"/> </td>
        <td> <img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/4924c6e9-09b1-4732-9e1e-786c80c79e06" alt="Sistema de avisos"/> </td>
    </tr>
</table>

<h3 align="center">Sistema de garage</h3>
<table>
    <tr> <th> Interacciones PED </th> <th> Lista de opciones </th> </tr>
    <tr>
        <td> <img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/20d9dc6e-7101-4c5f-bcd9-be3e154deccd" alt="Interacciones PED"/> </td>
        <td> <img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/860902cc-7a2a-408b-aa81-11cd3702c0d8" alt="Lista de opciones"/> </td>
    </tr>
</table>

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
        <td> <img src="https://github.com/imkuroneko/neko_restaurants/assets/20273059/5cca8634-269f-4318-bf20-b30150e4929e" alt="Vista cliente"/> </td>
    </tr>
</table>

-----

<p align="center">
  <a href="https://kuroneko.im" target="_blank">
    <img src="https://kuroneko.im/web/assets/images/profile.png" width="120">
  </a>
</p>
