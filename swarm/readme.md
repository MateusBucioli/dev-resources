# Docker in Docker (DinD) Swarm

Este é um exemplo simples de um [`docker swarm`](https://docs.docker.com/engine/swarm/) utilizando [`dind`](https://hub.docker.com/_/docker) para criar um cluster com 3 nós.

Assim que o cluster for criado, será disponibilizado um serviço do nginx, acessivel através do endereço `http://localhost:12080`.

## Getting started

Para iniciar o cluster, execute o comando abaixo:

```bash
docker compose up -d
```

---
Para verificar se o cluster foi criado corretamente, execute o comando abaixo:

```bash
docker exec -it manager docker node ls
```

Caso o cluster tenha sido criado corretamente, você verá algo similar a saída abaixo:

| ID                            | HOSTNAME       | STATUS | AVAILABILITY | MANAGER STATUS | ENGINE VERSION |
|-------------------------------|----------------|--------|--------------|----------------|----------------|
| j4dizgnr70pf09m6m9wo3eq8w *   | 43cd5b12e860   | Ready  | Active       | Leader         | 27.3.1         |
| 739blig2nt2k2wlayrcdjhikj     | af33da98b074   | Ready  | Active       |                | 27.3.1         |
| u19fvxmsd972mf8hru5fx4wb2     | c236479732fd   | Ready  | Active       |                | 27.3.1         |

---

Para verificar se o serviço do nginx subiu corretamente, utilize:

```bash
docker exec -it manager docker service ps nginx_nginx
```

O resultado deve ser similar ao abaixo:

| ID            | NAME           | IMAGE             | NODE         | DESIRED STATE | CURRENT STATE             | ERROR | PORTS |
|---------------|----------------|-------------------|--------------|---------------|---------------------------|-------|-------|
| n2zwl3gmfsrg  | nginx_nginx.1  | nginx:1.26-alpine | c96cafa9b945 | Running       | Running about a minute ago |       |       |
| xgd37op24yw0  | nginx_nginx.2  | nginx:1.26-alpine | c96cafa9b945 | Running       | Running about a minute ago |       |       |
| 2xda0etlet6l  | nginx_nginx.3  | nginx:1.26-alpine | c96cafa9b945 | Running       | Running about a minute ago |       |       |

## Scaling

Para escalar o serviço do nginx, execute o comando abaixo:

```bash
docker exec -it manager docker service scale nginx_nginx=5
```

---
Para verificar se o serviço foi escalado corretamente, execute o comando abaixo:

```bash
docker exec -it manager docker service ps nginx_nginx
```

Caso o serviço tenha sido escalado corretamente não haverá nenhuma informação na coluna `ERROR`.

## Testing

Utilizando o navegador ou `curl`, consulte o endereço `localhost:12080`, este deve exibir uma pagina com informações do nginx.

```bash
curl -X GET 0.0.0.0:12080
```

Deve retornar algo similar:

```html
<!DOCTYPE html>
<html lang="en" xml:lang="en">

<head>
    <title>Nginx</title>
</head>

<body>
    <h1>Hello from Nginx!</h1>
    <h2>Running on host: 1026e3dbf107</h2>
</body>
```

Caso o [`routing mesh`](https://docs.docker.com/engine/swarm/ingress/) do docker swarm esteja funcionando corretamente, é possivel que o host indicado seja diferente a cada consulta.

- `host` ou `hostname` é equivalente ao id do container que respondeu por esta requisição.

## Clean up

- Para remover totalmente o cluster, execute o comando abaixo:

```bash
docker compose down -v
```
