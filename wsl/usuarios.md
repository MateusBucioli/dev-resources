# Usuarios

## Trocando de usuario

```sh
su - NomeDoUsuario
```

## Verificando usuários disponíveis

- Caso não saiba o nome do usuário, é possível consultar a lista de usuários registrados com

    ```sh
    cat /etc/passwd
    ```

## Alterando usuário padrão do WSL2

- Acesse a distribuição desejada.
- Abra o arquivo `/etc/wsl.conf`.

    ```sh
    sudo nano /etc/wsl.conf
    ```

- Insira o conteúdo abaixo no arquivo, alterando `NomeDoUsuario` para o usuario desejado.

    ```wsl.conf
    [user]
    default=NomeDoUsuario
    ```

## Alterando a senha do usuário atual

- Acesse a distribuição com o usuário desejado.

- Para alterar a senha do usuário atual, utilize o comando abaixo:

    ```sh
    sudo passwd
    ```
