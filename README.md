# **Proyecto Terraform – Despliegue de Arquitectura en Azure**

![Portada del Proyecto](https://via.placeholder.com/1200x400?text=Portada+del+Proyecto)

## **Descripción del Proyecto**

Este proyecto tiene como objetivo desplegar una arquitectura completa en **Azure** mediante **Terraform** para un sistema contable.
La infraestructura incluye recursos como **App Service Plans**, **bases de datos SQL**, **redes virtuales (VNets)** y **Storage Accounts**,
todos orquestados para brindar soporte a las aplicaciones de contabilidad en la nube.

Este trabajo se basa en la creación de un **diagrama de arquitectura** y la implementación automatizada del despliegue con Terraform,
utilizando **código parametrizado** para facilitar la reutilización.

---

## **Componentes Principales**

1. **App Service Plans**: Para alojar aplicaciones web, tanto el frontend como el backend del sistema.
2. **Azure SQL Database**: Base de datos para almacenar información contable.
3. **Azure Container Registry (ACR)**: Almacenamiento de imágenes Docker de los servicios desplegados.
4. **Virtual Network (VNet)**: Red que interconecta los servicios en entornos privados.
5. **Subnets**: Aislamiento de servicios mediante subredes.
6. **Storage Accounts**: Almacenamiento adicional para logs y archivos.

---

## **Arquitectura del Proyecto**

El diagrama de arquitectura muestra cómo los servicios están interconectados. A continuación, se describe el flujo de trabajo:

![Diagrama del Proyecto](assets/diagrama-contapp.png)

---

## **Conclusión**

Este proyecto demuestra cómo utilizar **Terraform** para gestionar infraestructura en **Azure** de forma eficiente.
La arquitectura desplegada garantiza escalabilidad y seguridad, permitiendo una gestión contable eficaz en la nube.
