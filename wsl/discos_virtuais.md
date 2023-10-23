# Lidando com discos virtuais

## Movendo o volume (mnt) do WSL

[https://github.com/pxlrbt/move-wsl](https://github.com/pxlrbt/move-wsl)

## Exportando uma distribuição

- Abra o terminal.
- Execute o comando abaixo:

    ```powershell
    wsl --export <NomeDaDistribuicao> <NomeDoArquivo>
    ```

- Exemplo:

    ```powershell
    wsl --export Debian .\debian12.tar
    ```

## Importando uma distribuição

- Abra o terminal.
- Execute o comando

    ```powershell
    wsl --import <NomeDaDistribuicao> <DiretorioDeInstalacao> <DiretorioCompletoDoArquivo>
    ```

- Exemplo:

    ```Powershell
    wsl --import Debian C:\wsl\Debian12 .\debian12.tar
    ```
