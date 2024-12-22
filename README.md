<h1 align="center"><strong>INCEPTION - @42SP</strong></h1>

<p align="center">Broaden your knowledge of system administration by using Docker.</p>

<p align="center">
  <a href="https://www.42sp.org.br/" target="_blank">
    <img src="https://img.shields.io/static/v1?label=&message=SP&color=000&style=for-the-badge&logo=42">
  </a>
</p>
<p align="center">
  <img src="https://github.com/ayogun/42-project-badges/raw/main/badges/inceptione.png">
</p>
<p align="center"><strong>Grade: 100/100</strong> ✔️</p>

---

<h2 align="center"><strong>What is Inception?</strong></h2>

Inception is a project that focuses on enhancing your skills in system administration using Docker. You will build and configure a small infrastructure composed of multiple interconnected services, all virtualized within Docker containers.

---

<h2 align="center"><strong>Mandatory Features</strong></h2>

This project requires setting up a small infrastructure of Docker containers, each running a specific service. Below are the mandatory features:

- **Virtual Machine Environment**: The entire project must run on a virtual machine.
- **Docker Setup**:
  - Use `docker-compose.yml` to define and orchestrate the services.
  - Write individual `Dockerfiles` for each service.
  - Build custom Docker images without using pre-built images (except for Alpine/Debian).
- **Infrastructure Components**:
  - **NGINX**: Runs with TLSv1.2 or TLSv1.3 protocols and serves as the single entry point via port 443.
  - **MariaDB**: A database container without NGINX.
  - **WordPress**: Includes `php-fpm` and connects to MariaDB but does not include NGINX.
- **Volumes**:
  - Store the WordPress database.
  - Store the WordPress website files.
- **Networking**:
  - A Docker network that connects all containers.
  - No usage of `--link`, `links:`, or `network: host`.
- **Domain Configuration**:
  - Configure a domain (`eddo-sa.42.fr`) pointing to the local IP.
- **Environment Variables**:
  - Use `.env` files for credentials and configurations.
- **Best Practices**:
  - Containers must restart automatically in case of a crash.
  - Avoid hacky patches like `tail -f`, `sleep infinity`, or infinite loops in the entrypoint.

---

<h2 align="center"><strong>How to use</strong></h2>
- Clone this repository.
- Run 'make' to build the Docker images and start the services.
- Access the WordPress website at `https://eddos-sa.42.fr`.