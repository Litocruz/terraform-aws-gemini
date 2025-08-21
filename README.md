# Proyecto de Terraform: Despliegue de Instancia EC2

Este proyecto utiliza **Terraform** para automatizar el despliegue y la gestión del ciclo de vida de una instancia EC2 en dos entornos:

1.  **LocalStack**: Un entorno local para desarrollo y pruebas, sin incurrir en costos.
2.  **AWS Real**: Para desplegar la infraestructura en la nube de Amazon Web Services.

La infraestructura incluye una instancia EC2, un grupo de seguridad y un script de arranque que instala un servidor web Nginx. El estado de Terraform se gestiona de forma remota en un bucket de S3.

## Estructura del Proyecto

El proyecto está organizado en dos módulos principales para seguir las mejores prácticas de **Infraestructura como Código (IaC)**:

.
├── state/                          # Módulo para el backend de estado (bucket S3)
│   └── main.tf
└── main-infra/                     # Módulo principal para la infraestructura
     ├── main.tf
     ├── providers.tf
     ├── variables.tf
└── modules/
     └── ec2-instance/
             ├── main.tf
             ├── security-group.tf
             ├── variables.tf
             └── userdata.sh

## Requisitos Previos

Asegúrate de tener instalados los siguientes componentes en tu sistema:

* **Terraform**: Versión 1.0 o superior.
* **Docker**: Para ejecutar el contenedor de LocalStack.
* **AWS CLI**: Para interactuar con los servicios de AWS y LocalStack.
* **Git**: Para clonar el repositorio.

---

## Configuración

### 1. Configurar la cuenta de AWS (para despliegues en AWS real)

Para permitir que Terraform se conecte a tu cuenta de AWS, necesitas configurar credenciales de acceso. **No uses el usuario root**. Crea un usuario de IAM con los permisos necesarios para los servicios que uses (EC2, S3, etc.).

Luego, configura el AWS CLI con las credenciales de tu usuario de IAM:

```bash
aws configure

---------

## Flujos de trabajo

### 1. Despliegue en LocalStack (Entorno de desarrollo)

Para probar la infraestructura localmente, asegúrate de que tu contenedor de LocalStack esté en ejecución. La configuración por defecto del proyecto está optimizada para LocalStack.

1.  Inicia LocalStack en Docker:

    ```bash
    docker run --rm -it -p 4566:4566 -e SERVICES=ec2,s3 localstack/localstack
    ```

2.  Navega a la carpeta del proyecto principal y ejecuta los comandos de Terraform:

    ```bash
    terraform init
    terraform apply
    ```

### 2. Despliegue en AWS real

Para desplegar la infraestructura en AWS, necesitas anular el valor por defecto de la variable `environment`.

1.  Navega a la carpeta del proyecto principal.

2.  Ejecuta los comandos de Terraform con la variable `environment` establecida en `aws`:

    ```bash
    terraform init
    terraform apply -var="environment=aws"
    ```

### 3. Destruir la infraestructura

Para eliminar todos los recursos, asegúrate de que el estado de Terraform esté sincronizado y usa el comando `destroy`.

* Para el entorno de **LocalStack**:

    ```bash
    terraform destroy
    ```

* Para el entorno de **AWS real**:

    ```bash
    terraform destroy -var="environment=aws"
    ```

---

## Variables del proyecto

Puedes personalizar tu despliegue a través de variables. Las variables se encuentran en `main-infra/variables.tf`. Para anular sus valores por defecto, puedes usar la opción `-var` en la línea de comandos.

---

### Pipelines de CI/CD (GitHub Actions)

Este proyecto también incluye pipelines de CI/CD para automatizar el despliegue y la destrucción en AWS real. Estas pipelines usan los secretos de GitHub para conectarse a tu cuenta de AWS de forma segura.

Consulta el archivo `.github/workflows/create.yml` y `.github/workflows/destroy.yml` para ver la configuración detallada.

## Configuración del Backend

Una vez que hayas creado el bucket de estado en el directorio `state/`, debes configurar tu proyecto principal para que lo use.

En el archivo `main-infra/providers.tf`, añade el siguiente bloque dentro del bloque `terraform`:

```terraform
backend "s3" {
  bucket = "mi-bucket-de-estado-terraform-devops"
  key    = "terraform.tfstate"
  region = "us-east-1"
}

