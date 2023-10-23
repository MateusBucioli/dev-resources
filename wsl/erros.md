# Erros e possiveis soluções

## Portas não acessíveis

- Caso as portas do WSL não estejam acessíveis verifique [GitHub - Issue 4150](https://github.com/microsoft/WSL/issues/4150)

- Se ainda não estiver resolvido, tente utilizar as dicas do [comentario 4150-504209723](https://github.com/microsoft/WSL/issues/4150#issuecomment-504209723).

- Caso tenha problemas com a [instalação do Ubuntu 22.04](https://github.com/microsoft/WSL/issues/8525#issuecomment-1165632580), remova o Ubuntu já instalado e execute o comando:

    ```sql
    ubuntu2204.exe --ui=tui
    ```

- Após a instalação execute

    ```sql
    sudo apt update -y && sudo apt upgrade -y
    sudo apt install net-tools
    ```
